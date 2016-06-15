FROM ctac/base-ruby:2.1

ENV APP_HOME /var/app/social_media

RUN mkdir /var/app && mkdir $APP_HOME
WORKDIR $APP_HOME

RUN apt-get update && apt-get install git -y --no-install-recommends

ADD Gemfile* $APP_HOME/

ARG RAILS_ENV

RUN bundle install

ADD . $APP_HOME
RUN bundle exec rake assets:precompile
