#deploy.rb
set :stages, %w(production)
set :default_stage, "production"
require 'capistrano/ext/multistage'
require 'bundler/capistrano'

role (:web) {"#{domain}"}
role (:app) {"#{domain}"}
role (:db) { ["#{domain}", {:primary => true}] }

# Set the deploy branch to the current branch
set :application, "anchodemarca"
set :scm, :git
set (:repository) { "#{gitrepo}" }
set (:deploy_to) { "#{deploydir}" }
set :scm_user, "shivraj"
set :keep_releases, 2
ssh_options[:forward_agent] = true
default_run_options[:pty] = true

desc "Symlinks database.yml, mailer.yml file from shared directory into the latest release"
task :symlink_shared, :roles => [:app, :db] do
  run "ln -s #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
  run "ln -s #{shared_path}/system #{latest_release}/system"
end

after 'deploy:finalize_update', 'deploy:cleanup', :symlink_shared

namespace :deploy do
  desc "Reload the database with seed data"
  task :seed do
    run "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=#{rails_env}"
  end
end

namespace :deploy do
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end