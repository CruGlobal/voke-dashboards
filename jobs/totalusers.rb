require 'pg'

total_users = 0
db = PG.connect(:hostaddr => "10.16.20.86", :user => "USERNAME", :password => "PASSWORD", :port => 5432, :dbname => "voke_staging")

SCHEDULER.every '15s' do #, :first_in => 0 do |job|
  init_users = 0

  sql = "select count (distinct id) from users"

  db.exec(sql) do |results|

     items = results.map do |row|
        total_users = { :value => row['count'] }
     end

  end
  send_event('total_users', { current: total_users[:value], last: init_users })

end