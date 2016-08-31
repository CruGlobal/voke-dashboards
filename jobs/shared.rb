links_shared = 0
sql = "select count (distinct id) from messenger_conversations"

# SCHEDULER.every '5m' do #, :first_in => 0 do |job|
  init_users = 0

  $db.exec(sql) do |results|

     items = results.map do |row|
        links_shared = { :value => row['count'] }
     end

  end
  send_event('links_shared', { current: links_shared[:value], last: init_users })

# end
