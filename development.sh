#!/usr/bin/env bash
rm -f tmp/pids/server.pid && ./wait-for-it.sh db:3306 -- bundle exec rake db:create db:migrate services:load db:seed swagger:docs && bundle exec rails s --port 80 --binding '0.0.0.0'
