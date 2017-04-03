# http://stackoverflow.com/questions/5108876/kill-a-postgresql-session-connection
namespace :db do
  desc "Fix 'database is being accessed by other users'"
  task :terminate => :environment do
    next unless database_exists?
    ActiveRecord::Base.connection.execute <<-SQL
      SELECT
        pg_terminate_backend(pid)
      FROM
        pg_stat_activity
      WHERE
        -- don't kill my own connection!
        pid <> pg_backend_pid()
        -- don't kill the connections to other databases
        AND datname = '#{ActiveRecord::Base.connection.current_database}';
    SQL
  end

  def database_exists?
    ActiveRecord::Base.connection
  rescue ActiveRecord::NoDatabaseError
    false
  else
    true
  end
end

Rake::Task["db:drop"].enhance ["db:terminate"]
