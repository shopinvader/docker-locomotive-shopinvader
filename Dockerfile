FROM ruby:2.7.7

RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY install /usr/src/install
COPY bin /usr/src/bin

ENV BUILD_PACKAGE curl gpg git build-essential

COPY shopinvader ./

RUN DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y imagemagick nodejs $BUILD_PACKAGE \
    && /usr/src/install/gosu.sh \
    && /usr/src/install/shopinvader.sh \
    && apt-get upgrade -y -o Dpkg::Options::="--force-confold" \
    && apt-get purge -y $BUILD_PACKAGE \
    && apt-get clean

ENTRYPOINT ["/usr/src/bin/docker-entrypoint.sh"]

# Start puma server with loco user
CMD gosu loco bundle exec puma -C config/puma.rb

EXPOSE 3000
EXPOSE 9293

VOLUME \
    "/usr/src/app/tmp" \
    "/usr/src/app/log" \
    "/usr/src/app/public/sites" \
    "/usr/src/app/public/uploaded_assets"
