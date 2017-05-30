FROM akretion/voodoo-ruby:latest

LABEL maintainer "sebastien.beau@akretion.com"

USER root
ADD . /workspace
RUN bundle install && mkdir tmp log && chown ubuntu:ubuntu tmp log
USER ubuntu
CMD rails s --binding=0.0.0.0
