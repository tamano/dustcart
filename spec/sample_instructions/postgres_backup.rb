dump_site '/tmp/backup'

group :input do
  postgres 'target_db_name' do
    command '/usr/local/bin/pg_dump'
    host '127.0.0.1'
    port '5432'
    user 'backup_user'
    pass 'password'
  end
end
