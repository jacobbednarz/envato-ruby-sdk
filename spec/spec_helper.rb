$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'envato'
require 'vcr'
require 'webmock'
require 'webmock/rspec'

VCR.configure do |c|
  c.filter_sensitive_data('<ENVATO_API_TOKEN>')     { test_api_token }
  c.filter_sensitive_data('<ENVATO_API_USERNAME>')  { test_api_username }
  c.filter_sensitive_data('<ENVATO_PURCHASE_CODE>') { test_api_purchase_code }
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.default_cassette_options = {
    :serialize_with => :json,
    :record         => ENV['TRAVIS'] ? :none : :once
  }
end

def test_api_token
  ENV.fetch('ENVATO_TEST_API_TOKEN', 'x' * 32)
end

def test_api_username
  ENV.fetch('ENVATO_TEST_API_USERNAME', 'apideveloper')
end

def test_api_purchase_code
  ENV.fetch('ENVATO_PURCHASE_CODE', '1a2b3c4d-5e6f-7g8h-9i0j-1k2l3m4n5o6p')
end
