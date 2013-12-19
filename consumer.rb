#!/usr/bin/env ruby
# encoding: utf-8

require 'bundler/setup'
require 'beaneater'

STDOUT.sync = true

# Connect to pool
@beanstalk = Beaneater::Pool.new(['localhost:11300'])
# Enqueue jobs to tube
@tube = @beanstalk.tubes["my-tube"]

# Process jobs from tube
#while @tube.peek(:ready)

loop do
  job = @tube.reserve
  puts %{#{job.body}}

  # simulate time to process job / work
  sleep(10)

  job.delete
end

# Disconnect the pool
@beanstalk.close