require 'rubygems'
require 'fastercsv'
require 'time'
require 'active_support'

require File.expand_path(File.dirname(__FILE__) + '/string_extensions')
require File.expand_path(File.dirname(__FILE__) + '/project')
require File.expand_path(File.dirname(__FILE__) + '/task')
require File.expand_path(File.dirname(__FILE__) + '/duration')
require File.expand_path(File.dirname(__FILE__) + '/day')

class Report
  attr_reader :file, :projects
  def initialize
    @file = File.expand_path(File.join(ENV["HOME"], "times.csv"))
    parse(@file)
  end
  
  def project_filter
  end
  
  def period
    1.month.ago
  end
  
  def task_from_last_month?(date_string)
    task_time = Time.parse(date_string)
    task_time.year == period.year && task_time.month == period.month
  end
  
  def parse(file)
    @projects = {}
    
    FasterCSV.foreach(file, :col_sep => ";", :headers => true) do |row|
      next unless task_from_last_month?(row["Date"])
      next if project_filter && !(row["Project"] =~ project_filter)
      
      project_name = row["Project"]
      project = @projects[project_name]
      unless project
        @projects[project_name] = project = Project.new(project_name)
      end
      project.add_or_update_day(Time.parse(row["Date"]), row["Task"], row["Duration"])
    end
  end
  
  def summary
%(
Report for time period: #{period.strftime('%B')} #{period.strftime('%Y')}
#{projects.values.map{|p| p.summary }.join("\n")}
)
  end
end

if (__FILE__ == $0)
  print Report.new.summary
end