FROM ruby:2.7.0-alpine as builder

ARG DATABASE_URL
ARG RAILS_ENV
ARG SECRET_KEY_BASE
ARG NPM_CONFIG_PRODUCTION

RUN apk add \
build-base \
curl \
ca-certificates \
gnupg1 \
libffi-dev \
graphicsmagick \
libsodium-dev \
python \
make \
nodejs=12.15.0-r1 \
postgresql-dev \
tzdata \
yarn

WORKDIR /app
COPY Gemfile Gemfile.lock /app/

RUN bundle config --global frozen 1 \
&& bundle install --without development test -j4 --retry 3 \
&& rm -rf /usr/local/bundle/cache/*.gem \
&& find /usr/local/bundle/gems/ -name "*.c" -delete \
&& find /usr/local/bundle/gems/ -name "*.o" -delete

COPY . /app/
RUN yarn install

RUN RAILS_ENV='production' rails assets:precompile
RUN rm -rf node_modules tmp/* log/*

FROM ruby:2.7.0-alpine

RUN apk add --update --no-cache \
postgresql-dev \
graphicsmagick \
tzdata \
nodejs \
file

COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=builder /app/ /app/

WORKDIR /app

ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_SERVE_STATIC_FILES enabled
ENV NPM_CONFIG_PRODUCTION false
ENV RAILS_ENV production
ENV RACK_ENV production

EXPOSE 3000

CMD ["/bin/sh", "-c", "rails db:migrate && rails server -b 0.0.0.0 -p 3000"]
