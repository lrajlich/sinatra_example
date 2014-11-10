# Sinatra Redtrack Example
This is a simple sinatra application that demonstrates usage of the redtrack package. https://github.com/redhotlabs/redtrack

## Ruby Setup

Install bundler - http://bundler.io/
```
gem install bundler
```

Use bundler to install dependent gems
```
bundle install
```

## AWS Setup

This project depends on some AWS services - specifically Redshift and Kinesis. You must have an AWS account and a redshift cluster setup.

1) If you don't have one yet, Launch a Redshift cluster - https://console.aws.amazon.com/redshift/home

2) Edit configuration.rb - fill in appropriate values

3) Run script to setup AWS resources

```
bundle exec ruby setup_redtrack_aws_resources.rb
```

## Run The application
This can be run from an AWS EC2 instance or locally. If you run locally, make sure your ip address is authorized for your redshift cluster using the AWS console. 

Run the application server using foreman 
```
foreman start
```

This start up an application server with an endpoint that can be hit via browser to generate events for redtrack. Each time you hit the following url, a new event is generated to the broker.
```
http://localhost:3000/event?message=foobar
```

## Run Loader

The loader is a separate process which is meant to be run periodically to read events from the broker and COPY them into redshift. In general, you want to run this as a cron job periodically, eg, every 15 minutes. You want to run 1 loader per table, regardless of how many web servers you have generating events to the broker.

To run the loader manually, you can run the following:

```
bundle exec ruby load_redshift.rb
```

To install a cron job to periodically run the loader, there is a rake task...

When the loader is run, it will generate alot of output... The get_records request runs in a loop, 100 times, so there'll be a ton of INFO statements to that effect. If successful and events are loaded, the end of the output looks like this:
```
I, [2014-11-10T13:21:17.529420 #40630]  INFO -- : RedTrack::Loader (23.77s elapsed) Load kinesis shard into Redshift complete (41 events)
Load redshift Succeeded.
```

## Querying data

Now that data is loaded, you can query it as you would any other postgres database (Redshift is a postgres-based database). You need to install the psql client. (Alternatively you can use a GUI like dbvis). Example:
```
$ psql --host=REDSHIFT_HOSTNAME --port=5439 --username=USER_NAME --dbname=sinatra_example -W
Password for user dba: 
psql (9.3.5, server 8.0.2)
SSL connection (cipher: ECDHE-RSA-AES256-SHA, bits: 256)
Type "help" for help.

sinatra_example=# SELECT * FROM test_events LIMIT 5;
 client_ip | timestamp  | message 
-----------+------------+---------
 127.0.0.1 | 1415401844 | foo
 127.0.0.1 | 1415401851 | blarge
 127.0.0.1 | 1415646038 | blarge
 127.0.0.1 | 1415646633 | blah
 127.0.0.1 | 1415648805 | blah
(5 rows)
```
