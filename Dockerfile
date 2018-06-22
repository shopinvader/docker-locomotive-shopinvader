FROM ruby:2.5.1-stretch

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

RUN DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y imagemagick nodejs && \
    apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
    apt-get clean

ADD shopinvader ./
RUN bundle install --without development && mkdir -p tmp log && chown 9999:9999 tmp log
RUN bundle exec rake assets:precompile
RUN rm -rf log/* tmp/*

# Start puma server
CMD bundle exec puma -C config/puma.rb

EXPOSE 3000
EXPOSE 9293
