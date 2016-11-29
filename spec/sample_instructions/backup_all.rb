# where to put backup data temporary before uploading to S3
dump_site '/tmp/backup'

# which data to backup.
group :input do
  # Most simple way to backup directory
  directory '/tmp/target_directory'

  # Label can change directory's name in backup
  directory '/tmp/target_directory2' do
    label 'backup1'
  end

  # This also works
  directory '/tmp/target_directory3' do
  end

  # Backup files this way
  file '/tmp/target_file' do
    label 'backup_file'
  end

  # backup your postgresql db
  postgres 'target_db_name' do
    # if this not specified, pd_dump command in PATH will be used
    command '/usr/local/bin/pg_dump'

    host '127.0.0.1'
    port '5432'
    user 'backup_user'
    pass 'password'
  end

end

# where to upload
group :output do
  # Specifying Amazon S3 to backup all data in :input group
  # This is the only option just for now
  amazon_s3 :all do
    access_key_id 'MY_ACCESS_KEY_ID'
    secret_access_key 'MY_SECRET_ACCESS_KEY'
    region 'TARGET_REGION'
    bucket 'MY_BACKET'
  end
end

# cleanup the dump_site.
# Target can be :all or :except_latest
cleanup :except_latest
