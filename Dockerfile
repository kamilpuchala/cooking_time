## syntax = docker/dockerfile:1
#
## Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
#ARG RUBY_VERSION=3.2.2
#FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base
#
## Rails app lives here
#WORKDIR /rails
#
## Set production environment
#ENV RAILS_ENV="production" \
#    BUNDLE_DEPLOYMENT="1" \
#    BUNDLE_PATH="/usr/local/bundle" \
#    BUNDLE_WITHOUT="development"
#
#
## Throw-away build stage to reduce size of final image
#FROM base as build
#
## Install packages needed to build gems
#RUN apt-get update -qq && \
#    apt-get install --no-install-recommends -y build-essential git libpq-dev libvips pkg-config
#
## Install application gems
#COPY Gemfile Gemfile.lock ./
#RUN bundle install && \
#    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
#    bundle exec bootsnap precompile --gemfile
#
## Copy application code
#COPY . .
#
## Precompile bootsnap code for faster boot times
#RUN bundle exec bootsnap precompile app/ lib/
#
## Precompiling assets for production without requiring secret RAILS_MASTER_KEY
#RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile
#
#
## Final stage for app image
#FROM base
#
## Install packages needed for deployment
#RUN apt-get update -qq && \
#    apt-get install --no-install-recommends -y curl libvips postgresql-client && \
#    rm -rf /var/lib/apt/lists /var/cache/apt/archives
#
## Copy built artifacts: gems, application
#COPY --from=build /usr/local/bundle /usr/local/bundle
#COPY --from=build /rails /rails
#
## Run and own only the runtime files as a non-root user for security
#RUN useradd rails --create-home --shell /bin/bash && \
#    chown -R rails:rails db log storage tmp
#USER rails:rails
#
## Entrypoint prepares the database.
#ENTRYPOINT ["/rails/bin/docker-entrypoint"]
#
## Start the server by default, this can be overwritten at runtime
#EXPOSE 3000
#CMD ["./bin/rails", "server"]
FROM ruby:3.2.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs postgresql-client

# Install Yarn (for managing JavaScript dependencies)
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

# Set the working directory
WORKDIR /cooking_time

# Copy the Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN gem install bundler
RUN bundle install

# Copy the rest of the application code
COPY . /cooking_app

# Expose port 3000
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
