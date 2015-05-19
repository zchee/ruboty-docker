$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require "simplecov"
SimpleCov.start

require 'coveralls'
Coveralls.wear!

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'pry'
require 'ruboty/docker'
