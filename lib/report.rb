require 'rubygems'
require 'fastercsv'
require 'time'
require 'active_support'
require 'chronic'

require File.expand_path(File.dirname(__FILE__) + '/string_extensions')
require File.expand_path(File.dirname(__FILE__) + '/project')
require File.expand_path(File.dirname(__FILE__) + '/task')
require File.expand_path(File.dirname(__FILE__) + '/duration')
require File.expand_path(File.dirname(__FILE__) + '/day')

class Report
  attr_reader :file, :projects
  def initialize(opts)
    @project_filter = opts.delete(:project_filter)
    @time_period = opts.delete(:time_period) || :last_month
    @file = File.expand_path(File.join(ENV["HOME"], "times.csv"))
    parse(@file)
  end
  
  def period
    case @time_period
    when :last_month
      puts 1.months.ago.at_beginning_of_month.inspect
      1.months.ago.at_beginning_of_month..1.month.ago.at_end_of_month
    when :this_month
      0.months.ago.at_beginning_of_month..0.months.ago.at_end_of_month
    when :this_year
      0.years.ago.at_beginning_of_year..0.years.ago.at_end_of_year
    else
      if @time_period =~ /to/
        first, second = @time_period.split('to').collect(&:strip)

        first = Chronic.parse(first, :context => :past)
        second = Chronic.parse(second, :context => :past)
      
        first..second
      else
        Chronic.parse(@time_period, :guess => false, :context => :past)
      end
    end
  end
  
  def task_from_last_month?(date_string)
    task_time = Time.parse(date_string)
    period.include?(task_time)
  end
  
  def parse(file)
    @projects = {}
    
    FasterCSV.foreach(file, :col_sep => ";", :headers => true) do |row|
      next unless task_from_last_month?(row["Date"])
      next if @project_filter && !(row["Project"] =~ @project_filter)
      
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
Report for time period: #{period.first.strftime('%B %d %Y')} - #{period.last.strftime('%B %d %Y')}
#{projects.values.map{|p| p.summary }.join("\n")}
)
  end
end

if (__FILE__ == $0)
  print Report.new.summary
end