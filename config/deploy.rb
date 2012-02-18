# deploy script for cl_dash

role :web, "ec2-184-72-64-170.compute-1.amazonaws.com"
role :db, "ec2-184-72-64-170.compute-1.amazonaws.com", :primary => true

set :post_update_path, "/home/mv/ringsail/cap/current/config/postupdate/post_update_demo.sh"

set(:repository, Capistrano::CLI.ui.ask("GIT Repository: "))
set(:gituser, Capistrano::CLI.ui.ask("GIT Username: "))
set (:scm_password) { Capistrano::CLI.password_prompt("GIT Password: ") }

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
default_run_options[:pty] = true  # Must be set for the password prompt from git to work
set :scm, "git"
set :vhost, "ringsail"

require "bundler/capistrano"

set :application, "ringsail"
set :deploy_to, "/home/mv/ringsail/cap"
set :user, "mv"
set :runner, "mv"
set :deploy_via, :remote_cache
set :copy_strategy, :export

ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "mv_deploy_key")]

desc "uname for testing"
task :uname,  :roles => :web do
 run "uname -a"
end

desc "bundle list for testing"
task :bundlelist,  :roles => :web do
 default_run_options[:pty] = true
 run "cd /home/mv/ringsail/cap/current ; bundle list"
end

desc "bundle rake -T  for testing"
task :raket,  :roles => :web do
 default_run_options[:pty] = true
 #run "cd #{current_path} ; RAILS_ENV=tasks bundle exec rake -T"
 run "echo $PATH" 
end

# restart Apache web server
desc "restarts web server"
task :restart_apache_server, :roles => :web do
  sudo "/etc/init.d/apache2 restart", :max_hosts => 1
end

# custom task to stop Apache
desc "stop web server"
task :stop_apache_server, :roles => :web do
  sudo "/etc/init.d/apache2 stop"
  run "sleep 10"
end

# custom task to start Apache
desc "start web server"
task :start_apache_server, :roles => :web do
  sudo "/etc/init.d/apache2 start"
end

# override default info (prevents bundler from 
# running in the wromg directory for newer capistrano
# releases)
before "bundle:install", "override_current_release"
desc "set current_release variable to release_path"
task :override_current_release do
   set :current_release, "#{release_path}"
end

desc "some local post update tasks"
task :local_postupdate, :roles => :web do
   run "mkdir -p /home/mv/ringsail/cap/shared/log"
   run "find #{release_path} -type d -name .git | xargs rm -rf"
   run "touch #{release_path}/log/production.log"
   run "chmod 666 #{release_path}/log/production.log"
   run "mkdir /home/mv/ringsail/cap/shared/pids ; chown mv.mv /home/mv/ringsail/cap/shared/pids"

   set(:dbymlpath, Capistrano::CLI.ui.ask("Local location of database.yml file: "))
   upload("#{dbymlpath}","#{release_path}/config/database.yml", :mode => 0644)
end

desc "make releases directory"
task :mkreldir, :roles => :web do
   run "mkdir -p /home/mv/ringsail/cap/releases"
end

before "deploy:update_code", :mkreldir
after "deploy:update_code", :local_postupdate

#after "deploy:symlink", :post_update_scripts, :post_update_cache_symlinks
#after "deploy:symlink", :post_update_cache_symlinks

namespace :deploy do
  task :restart, :roles => :web do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

