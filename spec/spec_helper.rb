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

require 'ruboty/docker'

RSpec.configure do |config|
  config.color = true
  config.tty = true
  config.order = 'random'
  # config.formatter = 'documentation'
  # config.formatter = 'Fuubar'
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
