sql = "select topic, COUNT(*) AS Shared from messenger_conversations WHERE topic <> '' GROUP BY topic ORDER BY COUNT(*) DESC LIMIT 10"

# SCHEDULER.every '10m' do

   $db.exec(sql) do | results |
      topics = results.map do |row|
         row = { :label => row['topic'], :value => row['Shared'] }
      end
      send_event('topics', { items: topics })
   end

# end
