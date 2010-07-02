# multi-staging
# command : cap staging deploy
set :stages, %w(staging production)
set :default_stage, "production"

set :application, "lilyetfranck"

set :scm, :git
set :repository, "git@github.com:franck/#{application}.git"
set :branch, "master"
set :deploy_via, :remote_cache

ssh_options[:port] = 32100
set :user, "deploy"
set :admin_runner, "deploy"
set :git_enable_submodules, true

set :rake, "/opt/ruby-enterprise/bin/rake"

role :app, "lilyetfranck.com"
role :web, "lilyetfranck.com"
role :db, "lilyetfranck.com", :primary => true

task :production do
  set :deploy_to, "/var/www/#{application}/app"
  set :env, "production"
  # Deploy to production site only from stable branch
  set :branch, "stable"
end

task :staging do
  set :deploy_to, "/var/www/#{application}/staging"
  set :env, "staging"
end

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  
  desc <<-DESC
    Run the migrate rake task on the right stage.
  DESC
  task :migrate, :roles => :app do
    run "cd #{current_path}; #{rake} RAILS_ENV=#{env} db:migrate"
  end
  
  desc <<-DESC
    Create the database for the current RAILS_ENV
  DESC
  task :create, :roles => :app do
    run "cd #{current_path}; #{rake} RAILS_ENV=#{env} db:create"
  end
  
  desc <<-DESC
    Drop the database for the current RAILS_ENV
  DESC
  task :drop, :roles => :app do
    run "cd #{current_path}; #{rake} RAILS_ENV=#{env} db:drop"
  end
  
  desc <<-DESC
    Add initial data to database
  DESC
  task :bootstrap, :roles => :app do
    run "cd #{current_path}; #{rake} RAILS_ENV=#{env} merry:bootstrap"
  end  
  
  task :symlink_database, :roles => :app do
    run "ln -nfs #{release_path}/config/database.example.yml #{release_path}/config/database.yml"
  end
  
end
after "deploy", "deploy:cleanup"
after "deploy:update_code", "deploy:symlink_database"