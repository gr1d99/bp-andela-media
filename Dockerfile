FROM ruby:2.5.3-alpine

RUN apk add --update build-base postgresql-dev tzdata

RUN mkdir /app
WORKDIR /app
COPY Gemfile Gemfile.lock /app/
RUN bundle install

COPY . /app
