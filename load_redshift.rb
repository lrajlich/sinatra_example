require 'redtrack'
require 'yaml'
require './configuration'

loader = $redtrack_client.new_loader()

redshift_table = 'test_events'
stream_shard_index = 0

begin
  loader_result = loader.load_redshift_from_broker(redshift_table,stream_shard_index)
  puts 'Load redshift Succeeded.'
  exit 0
rescue RedTrack::LoaderException => e
  puts YAML.dump(e.information)
  puts e.message
  exit 1
end
