# Overwrite SQLite's #begin_db_transaction so it opens in IMMEDIATE
# mode instead of the default DEFERRED mode.  More info here:
#   https://discuss.rubyonrails.org/t/failed-write-transaction-upgrades-in-sqlite3/81480/2
if ActiveRecord::Base.connection.adapter_name == "SQLite"
  arca = ::ActiveRecord::ConnectionAdapters
  db_statements = arca::SQLite3::DatabaseStatements
  # Rails 7.1 and later
  if arca::AbstractAdapter.private_instance_methods.include?(:with_raw_connection)
    db_statements.define_method(:begin_db_transaction) do
      log("begin immediate transaction", "TRANSACTION") do
        with_raw_connection(allow_retry: true, uses_transaction: false) do |conn|
          conn.transaction(:immediate)
        end
      end
    end
  else
    # Rails < 7.1
    db_statements.define_method(:begin_db_transaction) do
      log("begin immediate transaction", "TRANSACTION") { @connection.transaction(:immediate) }
    end
  end
end
