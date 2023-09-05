import babel from 'esbuild-plugin-babel';
import chokidar from 'chokidar';
import esbuild from 'esbuild';
import rails from 'esbuild-rails';
import http from 'http';
import path  from 'path';
import {stimulusPlugin} from 'esbuild-plugin-stimulus';

// const chokidar = require('chokidar');
// const esbuild = require('esbuild');
// const rails = require('esbuild-rails');
// const babel = require('esbuild-plugin-babel');
// const http = require('http');
// const path = require('path');
// const { stimulusPlugin } = require('esbuild-plugin-stimulus');

const clients = [];
const watch = process.argv.includes('--watch');
const watchedDirectories = [
  './app/javascript/**/*.js',
  './app/views/**/*.html.erb',
  './app/views/**/*.rb',
  './app/assets/stylesheets/*.css',
];
const bannerJs = watch
  ? ' (() => new EventSource("http://localhost:8082").onmessage = () => location.reload())();'
  : '';

const config = {
  entryPoints: ['application.js'],
  bundle: true,
  outdir: path.join(process.cwd(), 'app/assets/builds'),
  absWorkingDir: path.join(process.cwd(), 'app/javascript'),
  watch: process.argv.includes('--watch'),
  plugins: [
       // Plugin to easily import Rails JS files, such as Stimulus controllers and channels
      // https://github.com/excid3/esbuild-rails
    rails(),
     stimulusPlugin(), 
      // Configures bundle with Babel. Babel configuration defined in babel.config.js
        // Babel translates JS code to make it compatible with older JS versions.
        // https://github.com/nativew/esbuild-plugin-babel
    babel()],
  sourcemap: true,
  logLevel: 'info',
  treeShaking: true,
  splitting: false,
  chunkNames: 'chunks/[name]-[hash]',
  incremental: watch,
  banner: { js: bannerJs },
  define: {
    global: 'window',
    RAILS_ENV: JSON.stringify(process.env.RAILS_ENV || 'development'),
    VERSION: JSON.stringify(process.env.IMAGE_TAG || 'beta'),
    COMMITHASH: JSON.stringify(process.env.GIT_COMMIT || ''),
  },
};

if (watch) {
  http
    .createServer((req, res) => {
      return clients.push(
        res.writeHead(200, {
          'Content-Type': 'text/event-stream',
          'Cache-Control': 'no-cache',
          'Access-Control-Allow-Origin': '*',
          Connection: 'keep-alive',
        }),
      );
    })
    .listen(8082);

  (async () => {
    const result = await esbuild.build(config);
    chokidar.watch(watchedDirectories).on('all', (event, path) => {
      if (path.includes('javascript')) {
        console.log(`rebuilding ${path}`);
        result.rebuild();
      }
      clients.forEach((res) => res.write('data: update\n\n'));
      clients.length = 0;
    });
  })();
} else esbuild.build(config).catch(() => process.exit(1));