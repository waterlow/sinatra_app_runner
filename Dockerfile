FROM ruby:3.2.2-slim

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential && \
    gem install sinatra puma

COPY myapp.rb .

EXPOSE 4567
CMD ["ruby", "myapp.rb", "-o", "0.0.0.0"]
