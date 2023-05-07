FROM ruby:3.2.2

RUN gem install sinatra puma
COPY myapp.rb .

EXPOSE 4567
CMD ["ruby", "myapp.rb", "-o", "0.0.0.0"]

