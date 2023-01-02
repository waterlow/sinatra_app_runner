FROM ruby:3.2.2-slim as base

WORKDIR /sinatra_app_runner

FROM base as build

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential && \
    gem install sinatra:3.0.6 puma:6.2.2 && \
    rm -rf /usr/local/bundle/cache

COPY . .

FROM base

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /sinatra_app_runner /sinatra_app_runner

EXPOSE 4567
CMD ["ruby", "myapp.rb", "-o", "0.0.0.0"]
