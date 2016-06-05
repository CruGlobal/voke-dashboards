require 'pg'

chatting = 0

sql = "select count (distinct messenger_id) from messenger_conversation_messages"

SCHEDULER.every '1m' do #, :first_in => 0 do |job|
  $db.exec(sql) do |results|

     items = results.map do |row|
        chatting = { :value => row['count'] }
     end

  end
  send_event('chatting', { current: chatting[:value] })
end
