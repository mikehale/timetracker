dir = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH << "#{dir}/../lib"

require 'rubygems'
require 'spec'
require 'rr'

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

class Time
  def self.now
    Time.local(2008, 8, 1, 0, 0, 0, 0)
  end
end

def prepare_report
  with_env do
    ENV['HOME'] = File.expand_path(File.dirname(__FILE__))
    @report = Report.new
  end
end
