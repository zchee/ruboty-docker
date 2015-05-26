require 'simplecov'
require 'coveralls'
require 'codeclimate-test-reporter'
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start
Coveralls.wear!
CodeClimate::TestReporter.start
if ENV['CIRCLE_ARTIFACTS']
  require 'simplecov'
  dir = File.join('..', '..', '..', ENV['CIRCLE_ARTIFACTS'], 'coverage')
  SimpleCov.coverage_dir(dir)
end
require 'ruboty/docker'

RSpec.configure do |config|
  config.color = true
  config.tty = true
  config.order = 'random'
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
