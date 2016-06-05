class LbMonitor
  def self.call(env)
    [200, {"Content-Type" => "text/plain"}, ["OK"]]
  end
end
