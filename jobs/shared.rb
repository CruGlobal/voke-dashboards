require 'pg'

links_shared = 0

db = PG.connect(:hostaddr => "10.16.20.86", :user => "USERNAME", :password => "PASSWORD", :port => 5432, :dbname => "voke_staging")

SCHEDULER.every '15s' do #, :first_in => 0 do |job|
  init_users = 0

  sql = "select count (distinct id) from messenger_conversations"

  db.exec(sql) do |results|

     items = results.map do |row|
        links_shared = { :value => row['count'] }
     end

  end
  send_event('links_shared', { current: links_shared[:value], last: init_users })

end