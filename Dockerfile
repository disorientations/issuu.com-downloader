FROM ruby:2-alpine

# Required to build native extensions required by project dependencies
RUN apk add ruby-dev make g++

# Required for bundle install to run
RUN gem install unf_ext -v '0.0.7.7' --source 'https://rubygems.org/'

# Add Gemfiles to install project dependencies
WORKDIR /app
ADD Gemfile* /app/

# Install project dependencies
RUN bundle install

# Invoke the script
ENTRYPOINT ["ruby", "issuu_downloader.rb" ]
