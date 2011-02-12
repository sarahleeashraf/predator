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

namespace :deploy do
	task :restart do
		run "touch #{current_path}/tmp/restart.txt"
	end
end