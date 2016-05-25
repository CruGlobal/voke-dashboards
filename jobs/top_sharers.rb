require 'pg'

db = PG.connect(:hostaddr => "10.16.20.86", :user => "USERNAME", :password => "PASSWORD", :port => 5432, :dbname => "voke_staging")

sql = "select users.last_name AS \"ln\", COUNT(messenger_friendships.friend_id) AS \"friends\" from messenger_friendships INNER JOIN users ON (messenger_friendships.messenger_id = users.id) WHERE users.last_name <> '' GROUP BY users.last_name ORDER BY COUNT(*) DESC LIMIT 15"

  SCHEDULER.every '1m' do

     db.exec(sql) do | results |
        top_sharers = results.map do |row|
           row = { :label => row['ln'], :value => row['friends'] }
        end
        send_event('top_sharers', { items: top_sharers })
     end
     
  end