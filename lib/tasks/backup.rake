namespace :db do

  desc "Backup database"
  task :backup => :environment do
    created_at = Time.now
    db_config = Rails.configuration.database_configuration[Rails.env]
    backups_config = YAML.load_file("#{Rails.root}/config/backups.yml")[Rails.env].symbolize_keys
    remote_file_name = "dumps/#{created_at}-#{Rails.env}.dump"

    dump_file = Tempfile.new "#{created_at.to_i}.dump"

    # run pg_dump
    `pg_dump #{db_config['host'] ? "-h" + db_config['host'] : ""} -U #{db_config['username']} #{db_config['database']} -Fc > #{dump_file.path}`

    # connect to S3
    puts "==  DB: Backup ======================================="
    objects = AWS::S3.new.buckets[backups_config[:s3_bucket]].objects
    puts "-- created dump with pg_dump"


    # upload new dump
    objects[remote_file_name].write dump_file
    puts "-- uploaded file #{remote_file_name} to S3"

    # delete old files
    objects.with_prefix('dumps/').each do |file|
      next if file.key == "dumps/"

      # when was created file
      file_created_at = File.basename(file.key, ".dump").gsub(/-\w+$/, "").to_time

      if created_at - file_created_at > 5.days
        file.delete
        puts "-- deleted old dump #{file.key}"
      end
    end

  end

end