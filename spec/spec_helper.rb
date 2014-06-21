require 'openstack_bridge'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

RSpec.configure do |config|
  config.mock_with :rspec
  config.filter_run focus: true
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.alias_example_to :fit, focus: true
  config.treat_symbols_as_metadata_keys_with_true_values = true
end
