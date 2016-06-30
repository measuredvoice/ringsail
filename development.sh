#!/usr/bin/env bash
./wait-for-it.sh -t 0 db:3306 -- bundle exec rake db:create db:migrate services:load db:seed swagger:docs && bundle exec rails s --port 80 --binding '0.0.0.0'
