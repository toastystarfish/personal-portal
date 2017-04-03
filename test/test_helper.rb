
if ENV['COVERAGE'] == '1'
  require 'simplecov'
  SimpleCov.coverage_dir 'test/coverage'
  SimpleCov.start 'rails'
end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'minitest/pride' if ENV['PRIDE'] == '1'

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
end
