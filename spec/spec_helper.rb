dir = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH << "#{dir}/../lib"

require 'rubygems'
require 'spec'
require 'rr'
require 'timecop'

Spec::Runner.configure do |config|
  config.mock_with :rr
end

def with_env
  old_env = {}
  old_env.replace(ENV)
  yield
ensure
  begin
    ENV.replace(old_env)
  rescue Exception => e
    raise
  end
end
