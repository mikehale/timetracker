module ReportSpecHelper
  def prepare_report
    Timecop.freeze(Time.local(2008, 8, 1, 0, 0, 0)) do
      with_env do
        ENV['HOME'] = File.expand_path(File.dirname(__FILE__))
        @report = Report.new
      end
    end
  end
end