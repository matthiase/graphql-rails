FROM ruby:2.6.5-slim-buster

ARG BUNDLER_VERSION

RUN apt-get update -qq
RUN apt-get install --fix-missing --no-install-recommends -qq -y \
  build-essential \
  libpq-dev \
  curl \
  vim

RUN apt-get -q clean

# Configure bundler
ENV LANG=C.UTF-8 \
  GEM_HOME=/bundle \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3
ENV BUNDLE_PATH $GEM_HOME
ENV BUNDLE_APP_CONFIG=$BUNDLE_PATH \
  BUNDLE_BIN=$BUNDLE_PATH/bin

ENV PATH $BUNDLE_BIN:$PATH

# Upgrade RubyGems and install required Bundler version
RUN gem update --system && \
    gem install bundler:2.0.2

# Create and set the working directory
WORKDIR /server


