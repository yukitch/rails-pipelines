FROM ruby:2.3.1-alpine

ARG approot=/

RUN echo $approot
RUN apk update && \
    apk add \
    mysql-client mysql-dev \
    nodejs \
    git less \
    imagemagick imagemagick-dev \
    tzdata \
    build-base \
    libxml2 libxml2-dev \
    libxslt libxslt-dev && \
    rm -fr /var/cache/apk/*

RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN mkdir -p $approot
WORKDIR $approot

ADD Gemfile $approot/
ADD Gemfile.lock $approot/

RUN bundle config --global build.nokogiri --use-system-libraries && \
    bundle install -j4
