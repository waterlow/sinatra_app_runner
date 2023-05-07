FROM ruby:3.2.2-slim as base

WORKDIR /sinatra_app_runner

ENV BUNDLE_PATH="/usr/local/bundle"

FROM base as build

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential

COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

FROM base

COPY myapp.rb ./

RUN rm -rf /var/lib/apt/lists /var/cache/apt/archives

COPY --from=build /usr/local/bundle /usr/local/bundle

EXPOSE 4567
CMD ["bundle", "exec", "ruby", "myapp.rb", "-o", "0.0.0.0"]
