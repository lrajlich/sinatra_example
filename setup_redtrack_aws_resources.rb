# This file creates aws resources that are needed for redtrack
require 'redtrack'
require './configuration'

# Create redshift database -
  # You can do this in the redshift cluster setup flow
  # If you have a cluster already and want to use a 2nd database, use postgres commandline
  # (connect to existing db, run "CREATE DATABASE {name}")

# Create the "kinesis_loads" table. This is used by the loader to determine which ranges of sequence numbers have already been loaded
begin
  $redtrack_client.create_kinesis_loads_table()
rescue Exception => e
  puts "Exception caught -- #{e.class}: #{e.message}\n\t#{e.backtrace.join("\n\t")}"
end

# Create redshift table
begin
  $redtrack_client.create_table_from_schema('test_events')
rescue Exception => e
  puts "Exception caught -- #{e.class}: #{e.message}\n\t#{e.backtrace.join("\n\t")}"
end

# Create kinesis stream for table
begin
  $redtrack_client.create_kinesis_stream_for_table('test_events')
rescue Exception => e
  puts "Exception caught -- #{e.class}: #{e.message}\n\t#{e.backtrace.join("\n\t")}"
end

# Create redshift table
begin
  $redtrack_client.create_table_from_schema('test_all_types')
rescue Exception => e
  puts "Exception caught -- #{e.class}: #{e.message}\n\t#{e.backtrace.join("\n\t")}"
end

# Create kinesis stream for table
begin
  $redtrack_client.create_kinesis_stream_for_table('test_all_types')
rescue Exception => e
  puts "Exception caught -- #{e.class}: #{e.message}\n\t#{e.backtrace.join("\n\t")}"
end


