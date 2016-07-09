FROM ctac/ruby-base:2.1

ENV APP_HOME /social_media

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install git nodejs -y --no-install-recommends && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD Gemfile* $APP_HOME/

ARG RAILS_ENV=production

RUN bundle install

ADD . $APP_HOME

RUN mkdir public/assets && \
  mkdir tmp && \
  mkdir tmp/pids

ARG REGISTRY_HOSTNAME=https://unprovided.domain
ARG REGISTRY_API_HOST=https://unprovided.domain

RUN bundle exec rake assets:precompile swagger:docs

EXPOSE 80
ENTRYPOINT [ "unicorn", "-c", "config/unicorn.rb" ]
