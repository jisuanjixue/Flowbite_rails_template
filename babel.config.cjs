const presets = [
    [
      // Javascript 2015+ syntax transpiler
      '@babel/preset-env',
      // Javascript Polyfill
      {
        useBuiltIns: 'usage',
        // Make sure version number matches the Core.js version installed in your project
        corejs: '3.28.0',
        targets: {
          node: 'current'
        }
      }
    ]
  ]
  
  module.exports = {
    presets,
    // Fixes Core-JS $ issue: https://github.com/zloirock/core-js/issues/912
    exclude: ['./node_modules']
  }