require 'redtrack'
require 'yaml'

# Parse argv
redshift_table = nil
ARGV.each_with_index do |argument,index|
  case argument
    when "-t", "--table"
      redshift_table=ARGV[index+1]
  end
end

if redshift_table == nil
  raise "Must specify --table. For this example, 'test_events' or 'test_all_types' are valid"
end

# Create redtrack client
require './configuration'

# Create loader
loader = $redtrack_client.new_loader()

begin
  loader_result = loader.load_redshift_from_broker(redshift_table)
  puts 'Load redshift Succeeded.'
  YAML::dump(loader_result)
  exit 0
rescue RedTrack::LoaderException => e
  puts YAML.dump(e.information)
  puts e.message
  exit 1
end
