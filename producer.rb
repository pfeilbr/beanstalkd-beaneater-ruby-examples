#!/usr/bin/env ruby
# encoding: utf-8

require 'bundler/setup'
require 'beaneater'
require 'time'
require 'date'

STDOUT.sync = true

# Connect to pool
@beanstalk = Beaneater::Pool.new(['localhost:11300'])
# Enqueue jobs to tube
@tube = @beanstalk.tubes["my-tube"]

loop do
	msg = %{msg is #{Time.now}}
	puts %{enqueuing #{msg}}
	@tube.put msg
	sleep(5)
end