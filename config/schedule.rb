job_type :runner,    "cd :path && /Users/lrajlich/.rvm/gems/ruby-2.1.2@global/bin/bundle exec ruby :task :output"

# Load redshift
every '* * * * *' do
  runner 'load_redshift.rb', :output => '/tmp/load_redshift.out'
end
