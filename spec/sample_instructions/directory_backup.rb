dump_site '/tmp/backup'

group :input do
  directory '/tmp/target_directory' do
  end

  directory '/tmp/target_directory2' do
    label 'backup1'
  end

  directory '/tmp/target_directory3'
end
