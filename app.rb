require 'sinatra'
require 'redtrack'
require 'time'
require 'yaml'

# Require the configuration file containing configuration for redshift
require './configuration'

## Configuration for sinatra. Bind to port 8080 on all interfaces
set :bind, '0.0.0.0'
set :port, 3000
set :logging, true


## App Endpoints
get '/ping' do
  'pong'
end

get '/event' do

  data = {
      :client_ip => request.ip.to_s,
      :timestamp => Time.now.to_i,
  }

  if params[:message] != nil
    data[:message] = params[:message]
  end

  result = $redtrack_client.write("test_events",data)

  # Write output back to the client
  stream do |out|
    if result
      out << "<PRE>OK\n#{YAML.dump(data)}</PRE>"
    else
      out << "<PRE>FAIL</PRE>"
    end
  end

end
