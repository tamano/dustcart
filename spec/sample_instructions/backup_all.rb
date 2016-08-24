dump_site '/tmp/backup'

group :input do
  directory '/tmp/target_directory' do
  end

  directory '/tmp/target_directory2' do
    label 'backup1'
  end

  directory '/tmp/target_directory3'

  file '/tmp/target_file' do
    label 'backup_file'
  end
end

group :output do
  amazon_s3 :all do
    access_key_id 'MY_ACCESS_KEY_ID'
    secret_access_key 'MY_SECRET_ACCESS_KEY'
    region 'TARGET_REGION'
    bucket 'MY_BACKET'
  end
end

cleanup :except_latest
