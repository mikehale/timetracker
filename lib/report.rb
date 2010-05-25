require 'rubygems'
require 'fastercsv'
require 'time'
require 'active_support'

require File.expand_path(File.dirname(__FILE__) + '/project')
require File.expand_path(File.dirname(__FILE__) + '/task')
require File.expand_path(File.dirname(__FILE__) + '/duration')

class Report
  attr_reader :file, :projects
  def initialize
    @file = File.expand_path(File.join(ENV["HOME"], "times.csv"))
    parse(@file)
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
      
      project_name = row["Project"]
      project = @projects[project_name]
      @projects[project_name] = project = Project.new(project_name) unless project
      project.add_task(row["Task"], row["Duration"])
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