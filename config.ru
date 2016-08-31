require 'dotenv'
Dotenv.load
require './lib/lb_monitor'
require 'pg'

$db = PG.connect(:host => ENV['DB_PORT_5432_TCP_ADDR'],
                 :user => ENV['DB_ENV_POSTGRESQL_USER'],
                 :password => ENV['DB_ENV_POSTGRESQL_PASS'],
                 :port => 5432,
                 :dbname => ENV['DB_ENV_POSTGRESQL_DB'])

require 'dashing'


configure do
  set :auth_token, ENV['AUTH_TOKEN']

  helpers do
    def protected!
      unless authorized?
        response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
        throw(:halt, [401, "Not authorized\n"])
      end
    end

    def authorized?
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
      ENV['AUTH_USER'] && ENV['AUTH_PASS'] && @auth.provided? && @auth.basic? &&
        @auth.credentials && @auth.credentials == [ENV['AUTH_USER'], ENV['AUTH_PASS']]
    end
  end
end


map '/monitors/lb' do
  run LbMonitor
end

map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

run Sinatra::Application

