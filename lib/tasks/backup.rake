namespace :db do

  desc "Backup database"
  task :backup => :environment do
    DumpDatabase.perform_async
  end

end