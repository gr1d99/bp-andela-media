[![Maintainability](https://api.codeclimate.com/v1/badges/625d81749b20f55b6b40/maintainability)](https://codeclimate.com/github/andela/bp-andela-media/maintainability)  [![Build Status](https://travis-ci.org/andela/bp-andela-media.svg?branch=develop)](https://travis-ci.org/andela/bp-andela-media)  [![Test Coverage](https://api.codeclimate.com/v1/badges/625d81749b20f55b6b40/test_coverage)](https://codeclimate.com/github/andela/bp-andela-media/test_coverage)
# Andela Media
Andela media lets the Andela media team manage images and photos of the great Andela fraternity.

## Requirements

#### Ruby

This application uses Ruby version `2.5.3`. To install use `rvm` or `rbenv`.

* RVM

        rvm install 2.5.3
        rvm use 2.5.3
    - To set Ruby `2.5.3` as the default Ruby version for your computer, run 
        
            rvm use 2.5.3 --default

* Rbenv

        rbenv install 2.5.3
    - To switch to `2.5.3` temporarily for this project, use 
            
            rbenv local 2.5.3
    
    - To use this version as the default Ruby version for your global environment, use 
            
            rbenv global 2.5.3

#### Bundler

Bundler provides a consistent environment for Ruby projects by tracking and installing the exact gems and versions that are needed

To install:

        gem install bundler

#### Rails

This applications uses the one of the latest versions of rails. You will need to upgrade if you don't already have it istalled. The rails version being used is `rails 5.2.1`.

To install:

        gem install rails

#### PostgreSQL

This application makes use of the postgres database. For local development, you need to install it.
To install postgres using `brew`:

        brew install postgresql
    
For extra information on how to configure, make use of this [tutorial](https://www.codementor.io/engineerapart/getting-started-with-postgresql-on-mac-osx-are8jcopb).

To install postgres using a client make use of this application - [Postgres.app](https://postgresapp.com/)

These are just recommendations, feel free to look up more ways of installing and configuring postgresSQL.

## Installation

To get up and running with the project locally, follow the following steps.

* Clone the app

        git clone https://github.com/andela/bp-andela-media.git

* Move into the directory and install all the requirements.

    ```bash
    cd bp-andela-media/

    bundle install
    ```

* Setup the database

    Open the project in your code editor and find the files `/config/creds/development.yml` and `/config/creds/test.yml` and change the credetials to match your postgres settings.

    Then run:

        rails db:create
        rails db:migrate

* Run the application

        foreman start

    Now visit [localhost:3000](http://localhost:3000)

## Docker
This application set up using **Docker Compose**, run the commands below in your terminal to get started.

**NB** You need to [install](https://docs.docker.com/compose/install/) compose

```bash
$ docker-compose build web
$ docker-compose run web rake db:create
$ docker-compose up web
```

## Conventions

Use the [Engineering playbook](https://github.com/andela/engineering-playbook/tree/master/5.%20Developing/Conventions) conventions for writing commits, branch naming and Pull request body and title conventions.

## Contributors

Andela D1 Ruby developers on the bench.
