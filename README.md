# Sinatra Redtrack Example

## Ruby Setup

This

Install bundler - http://bundler.io/
```
gem install bundler
```

Install dependent gems

```
bundle install
```

## AWS Setup

This project depends on some AWS services - specifically Redshift and Kinesis. You must have an AWS account and a redshift cluster setup.

Edit configuration.rb - fill in appropriate values

Run script to setup AWS resources

```
bundle exec ruby setup_redtrack_aws_resources.rb
```
