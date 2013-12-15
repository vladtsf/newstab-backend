require "resque/tasks"

task "resque:setup" => :environment do
  Resque.logger = Logger.new("#{Rails.root}/log/resque.log")
end