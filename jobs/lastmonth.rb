require 'pg'

monthly_users = 0

SCHEDULER.every '1d' do #, :first_in => 0 do |job|
  init_users = 0

#  send_event('valuation', { current: total_users, last: init_users })

  db = PG.connect(:hostaddr => "10.16.20.86", :user => "USERNAME", :password => "PASSWORD", :port => 5432, :dbname => "voke_staging")

  sql = "SELECT count (last_sign_in_at > CURRENT_DATE - INTERVAL'1 month') from users"

  db.exec(sql) do |results|

     items = results.map do |row|
        monthly_users = { :value => row['count'] }
     end

  end
  send_event('last_month', { current: monthly_users[:value], last: init_users })

end