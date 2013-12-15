class DumpDatabase
  @queue = :dump_database

  def self.perform
    created_at = Time.now
    db_config = Rails.configuration.database_configuration[Rails.env]
    backups_config = YAML.load_file("#{Rails.root}/config/backups.yml")[Rails.env].symbolize_keys
    remote_file_name = "dumps/#{created_at}-#{Rails.env}.dump.bz2"

    dump_file = Tempfile.new "#{created_at.to_i}.dump.bz2"

    # run pg_dump
    `pg_dump #{db_config['host'] ? "-h" + db_config['host'] : ""} -U #{db_config['username']} #{db_config['database']} | bzip2 > #{dump_file.path}`

    # connect to S3
    objects = AWS::S3.new.buckets[backups_config[:s3_bucket]].objects

    # upload new dump
    objects[remote_file_name].write dump_file
  end
end