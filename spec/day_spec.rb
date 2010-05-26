require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require 'report'
require 'day'

describe Day do
  before(:each) do
    prepare_report
    @project1 = @report.projects.detect {|name, project| name == "project1" }.last
    @day1 = @project1.days.detect {|day| day.date == Time.parse("2008-07-09") }
    @day2 = @project1.days.detect {|day| day.date == Time.parse("2008-07-18") }
    @day3 = @project1.days.detect {|day| day.date == Time.parse("2008-07-24") }
    @day4 = @project1.days.detect {|day| day.date == Time.parse("2008-07-28") }
  end
  
  # "project1";"task1";"2008-07-09";"2008-07-09 13:58:28";"2008-07-09 14:29:10";"00:30:41";""
  
  # "project1";"task1";"2008-07-18";"2008-07-09 15:08:14";"2008-07-09 16:24:58";"01:16:44";""
  # "project1";"task2";"2008-07-18";"2008-07-18 14:44:32";"2008-07-18 15:23:47";"00:39:15";""
  
  # "project1";"task1";"2008-07-24";"2008-07-09 16:34:37";"2008-07-09 16:59:02";"00:24:24";""
  # "project1";"task3";"2008-07-24";"2008-07-24 09:02:25";"2008-07-24 09:50:48";"00:48:23";""
  # "project1";"task3";"2008-07-24";"2008-07-24 10:13:02";"2008-07-24 10:48:05";"00:35:03";""
  
  # "project1";"task4";"2008-07-28";"2008-07-28 11:56:39";"2008-07-28 12:39:51";"00:43:12";""
  
  
  it "should have the correct number of tasks for each day" do
    @day1.tasks.size.should == 1
    @day2.tasks.size.should == 2
    @day3.tasks.size.should == 2
    @day4.tasks.size.should == 1
  end
  
  it "should include each task in the summary" do
    @day1.summary.should include("task1")
    
    @day2.summary.should include("task1")
    @day2.summary.should include("task2")
    
    @day3.summary.should include("task1")
    @day3.summary.should include("task3")
  end
  
  it "should include the time worked each day" do
    @day1.summary.should include("0.51")
    @day2.summary.should include("1.93")
    @day3.summary.should include("1.8")
    @day4.summary.should include("0.72")
  end
  
  it "should include the date worked" do
    @day1.summary.should include("2008-07-09")
    @day2.summary.should include("2008-07-18")
    @day3.summary.should include("2008-07-24")
    @day4.summary.should include("2008-07-28")
  end

end
