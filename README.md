# README


# Templatus (use hotwire edition)
Template is an opinionated template to build web applications with Ruby on Rails and flowbite ui. It simplifies the process of setting up a new application while following best practices.

Live demo available at

### Backend

- [Ruby](https://www.ruby-lang.org/de/) 3.2.2
- [Ruby on Rails](https://rubyonrails.org/) 7.0.4
[PostgreSQL](https://www.postgresql.org/) for use as SQL database
- [Sidekiq](https://sidekiq.org/) for background processing
- [Redis](https://redis.io/) for Caching, ActionCable, and Sidekiq
- [Puma](https://puma.io/) is a simple, fast, multi-threaded, and highly concurrent HTTP 1.1 server for Ruby/Rack applications.

### Frontend

- [hotwire](https://hotwired.dev/) Hotwire is an alternative approach to building modern web applications without using much JavaScript by sending HTML instead of JSON over the wire
- [Tailwind CSS 3](https://tailwindcss.com/) to not have to write CSS at all
- [https://flowbite.com/](https://heroicons.com/) Build websites even faster with components on top of Tailwind CSS.
- [esbuild](https://esbuild.github.io/) An extremely fast bundler for the web

### Development

- [Foreman](https://github.com/ddollar/foreman) for starting up the application locally
- [dotenv](https://github.com/bkeepers/dotenv) to load environment variables from .env into ENV
- [Prettier](https://prettier.io/) for auto-formatting JavaScript and Ruby code in Visual Studio Code
- [Lookbook](https://github.com/allmarkedup/lookbook) as development UI for ViewComponent
- Live reloading

### Linting and testing

- [RuboCop](https://rubocop.org/) for Ruby static code analysis
- [ESLint](https://eslint.org/) for JavaScript static code analysis
- [RSpec](https://rspec.info/) for Ruby testing
- [Factory Bot](https://github.com/thoughtbot/factory_bot) for setting up Ruby objects as test data
- [Cypress](https://www.cypress.io/) for E2E testing

### Deployment

- [Docker](https://www.docker.com/) for production deployment, NOT for development
- [GitHub Actions](https://docs.github.com/en/actions) for testing, linting, and building Docker image
- [Dependabot](https://docs.github.com/en/code-security/supply-chain-security/keeping-your-dependencies-updated-automatically/about-dependabot-version-updates) configuration for updating dependencies (with auto-merge)
- Ready for serving assets via CDN like CloudFront
- [Lockup](https://lockup.interdiscipline.com/) to place a staging server behind a basic codeword


## Getting started

### Install for development

1. Clone the repo locally:

```bash
git clone https://github.com/jisuanjixue/Flowbite_rails_template
cd Flowbite_rails_template
```

1. Install PostgreSQL, Redis, ruby, gem, javascript node module etc Setup the application to install gems and NPM packages and create the database::

```bash
bin/setup
```

5. Start the application locally:

```bash
bin/dev
```

Then open http://localhost:3000 in your browser.


### Running linters

RuboCop:

```
bin/rubocop
```

ESLint:

```
bin/yarn lint
```

### Running tests locally

Ruby tests:

```
bin/rspec
open coverage/index.html
```

JavaScript unit tests:

```
bin/yarn test
```

E2E tests with Cypress:

```
bin/cypress open
```

This opens Cypress and starts Rails in `development` environment, but with `CYPRESS=true`, so the `test` database is used. This allows code editing without class reloading and recompiling assets.

To run Cypress in headless mode:

```
bin/cypress run
```

### Test deployment locally

```
docker network create public
docker-compose up
```

