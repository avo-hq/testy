# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

# neable this to use Avo from the main repo
if false
  Rake::Task["assets:precompile"].enhance(["avo:sym_link"])
end

