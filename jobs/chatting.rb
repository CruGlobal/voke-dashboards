require 'pg'

chatting = 0

db = PG.connect(:hostaddr => "10.16.20.86", :user => "USERNAME", :password => "PASSWORD", :port => 5432, :dbname => "voke_staging")

SCHEDULER.every '1m' do #, :first_in => 0 do |job|
  init_users = 0

  sql = "select count (distinct messenger_id) from messenger_conversation_messages"

  db.exec(sql) do |results|

     items = results.map do |row|
        chatting = { :value => row['count'] }
     end

  end
  send_event('chatting', { current: chatting[:value] })

end