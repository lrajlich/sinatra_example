require 'redtrack'

## Configuration for redtrack
SCHEMAS= {
    :test_events => {
        :columns => {
            :client_ip =>     { :type => 'varchar(32)', :constraint => 'not null'},
            :timestamp =>     { :type => 'integer', :constraint => 'not null'},
            :message =>       { :type => 'varchar(128)' }
        },
        :sortkey => 'timestamp'
    },
    :test_all_types => {
        :columns => {
            :test_smallint =>     { :type => 'smallint'},
            :test_integer =>      { :type => 'integer', :constraint => 'not null'},
            :test_bigint =>       { :type => 'bigint'},
            :test_decimal =>      { :type => 'decimal(8,2)'},
            :test_real =>         { :type => 'real'},
            :test_double =>       { :type => 'double precision'},
            :test_bool =>         { :type => 'boolean'},
            :test_char =>         { :type => 'char(32)'},
            :test_varchar =>      { :type => 'varchar(32)', :constraint => 'not null'},
            :test_date =>         { :type => 'date'},
            :test_timestamp =>    { :type => 'timestamp'}
        },
        :sortkey => 'test_timestamp'
    }
}

redtrack_options = {
    :access_key_id => nil,# fill in AWS ACCESS KEY,
    :secret_access_key => nil,# fill in AWS SECRET KEY,
    :s3_bucket => nil,# Fill in Bucket where the load,
    :region => nil,# fill in aws Region, s3 bucket and redshift must be in the same region
    :redshift_cluster_name => nil, # Fill in Name of the redshift cluster
    :redshift_host => nil, # Fill in - This is the Endpoint under Cluster Database Properties on redshift cluster configuration
    :redshift_port => '5439', # Port under Cluster Database Properties on redshift cluster configuration. Default is 5439
    :redshift_dbname => nil, # Fill in - Database Name under Cluster Database Properties on redshift cluster configuration
    :redshift_user => nil, # Fill in - Master Username under Cluster Database Properties on redshift cluster configuration
    :redshift_password => nil, # Fill in - Password used for the above user
    :redshift_schema => SCHEMAS, # Schemas defined above
    :kinesis_enabled => true, # Set to false in a development environment - writes to a file instead of kinesis
    :verbose => true #
}

$redtrack_client = RedTrack::Client.new(redtrack_options)