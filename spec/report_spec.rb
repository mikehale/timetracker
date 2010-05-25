require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require 'report'
require 'report_spec_helper'

class Time
  def self.now
    Time.local(2008, 8, 1, 0, 0, 0, 0)
  end
end

describe Report do
  include ReportSpecHelper
  
  before(:each) do
    prepare_report
  end
  
  it "should load the csv file of the current user" do
    @report.file.should == "#{File.expand_path(File.dirname(__FILE__))}/times.csv"
  end
  
  it "should have the correct number of projects for last month" do
    @report.projects.should have(2).things
  end
  
  describe "summary" do
    it "should include the time period" do
      @report.summary.should include("Report for time period: July 2008")
    end

    it "should include the project name" do
      @report.summary.should include("project1")
      @report.summary.should include("project2")
    end
  end
end

