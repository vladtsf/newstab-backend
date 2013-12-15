namespace :db do

  desc "Backup database"
  task :backup => :environment do
    Resque.enqueue DumpDatabase
  end

end