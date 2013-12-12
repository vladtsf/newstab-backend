env :PATH, ENV['PATH']
# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
every 10.minutes do
  rake "feeds:parse"
end

every 3.hours do
  rake "db:backup"
end

# Learn more: http://github.com/javan/whenever
