total_users = 0

# SCHEDULER.every '5m', :first_in => 0 do
  init_users = 0

  sql = "select count (distinct id) from users"

  $db.exec(sql) do |results|

     items = results.map do |row|
        total_users = { :value => row['count'] }
     end

  end
  send_event('total_users', { current: total_users[:value], last: init_users })

# end
