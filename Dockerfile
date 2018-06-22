FROM ruby:2.5.1-stretch

RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY install /usr/src/install
COPY bin /usr/src/bin

RUN DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y imagemagick nodejs && \
    /usr/src/install/gosu.sh \
    apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
    apt-get clean

COPY shopinvader ./
RUN bundle install --without development && mkdir -p tmp log && chown 9999:9999 tmp log
RUN bundle exec rake assets:precompile
RUN rm -rf log/* tmp/*

ENTRYPOINT ["/usr/src/bin/docker-entrypoint.sh"]

# Start puma server with loco user
CMD gosu loco bundle exec puma -C config/puma.rb

EXPOSE 3000
EXPOSE 9293

VOLUME [ \
    "/usr/src/app/tmp" \
    "/usr/src/app/log" \
    "/usr/src/app/public/sites" \
    "/usr/src/app/public/uploaded_assets" \
]
