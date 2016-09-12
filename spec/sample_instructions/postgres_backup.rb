dump_site '/tmp/backup'

group :input do
  postgres 'target_db_name' do
    host '127.0.0.1'
    port '5432'
    user 'backup_user'
    pass 'password'
  end
end
