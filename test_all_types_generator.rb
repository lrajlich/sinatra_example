# this is an example showing all data types - generates events in a loop


require 'redtrack'
require 'yaml'
require 'securerandom'
require './p_configuration'


while true do

  data = {
      :test_smallint => rand(100),
      :test_integer => rand(100),
      :test_bigint => rand(100),
      :test_decimal => BigDecimal.new("#{rand(1000)}.#{rand(100)}"),
      :test_real => rand(100).to_f / (rand(100)+1).to_f,
      :test_double => rand(100).to_f / (rand(100)+1).to_f,
      :test_bool => rand(10) % 2 == 0? true : false,
      :test_char => SecureRandom.hex,
      :test_varchar => SecureRandom.uuid,
      :test_date => Date.today,
      :test_timestamp => Time.now
  }

  puts '***************************'
  puts YAML::dump(data)

  result = $redtrack_client.write('test_all_types',data)
end