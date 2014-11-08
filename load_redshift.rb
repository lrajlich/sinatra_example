require 'redtrack'
require 'yaml'
require './configuration'

loader = $redtrack_client.new_loader()

redshift_table = 'test_events'
stream_shard_index = 0

loader_result = loader.load_redshift_from_broker(redshift_table,stream_shard_index)

if loader_result[:success] == false

  information = {
      :loader_result => loader_result,
      :parameters => {
          :redshift_table => redshift_table,
          :stream_shard_index => stream_shard_index
      },

  }

  puts YAML::dump(information)

  if information[:failure_type] == "ERROR"
    puts 'Load redshift Failed!'
    exit 1
  else
    puts 'Load redshift Exited with warning!'
    exit 0
  end
end

puts 'Load redshift Succeeded.'
