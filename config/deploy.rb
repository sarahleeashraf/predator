set :user, 'predator'
set :domain, 'www.predatorenergy.com'
set :application, "predator"

set :repository,  "git@github.com:sarahleeashraf/predator.git"
set :deploy_to, "/home/predator/predator_app/public"

role :app, domain
role :web, domain
role :db,  domain, :primary => true

default_run_options[:pty] = true

set :deploy_via, :remote_cache
set :scm, 'git'
set :branch, 'master'
set :scm_verbose, true
set :use_sudo, false


after 'deploy:update_code', 'deploy:symlink_db'

namespace :deploy do
	task :restart do
		run "touch #{current_path}/tmp/restart.txt"
	end
	
	desc "Symlinks the database.yml"
	task :symlink_db, :roles => :app do
		run "ln -nfs /home/predator/database_config/database.yml /home/predator/predator_app/public/current/config/database.yml"
	end
	
end