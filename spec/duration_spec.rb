require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require 'duration'

describe Duration do
  describe "value" do
    it "returns decimal representation of time" do
      duration = Duration.new("00:30:00")
      duration.value.should == 0.5

      duration = Duration.new("00:45:00")
      duration.value.should == 0.75

      duration = Duration.new("01:30:00")
      duration.value.should == 1.5

      duration = Duration.new("00:00:900") # 15 minutes in seconds
      duration.value.should == 0.25

      duration = Duration.new("1:15:900")
      duration.value.should == 1.5
    end
  end
  
  describe "+" do
    it "should correctly add times" do
      d1 = Duration.new("00:30:00")
      d2 = Duration.new("00:30:00")
      (d1 + d2).value.should == 1.0

      d1 = Duration.new("1:45:00")
      d2 = Duration.new("2:30:00")
      (d1 + d2).value.should == 4.25
    end

    it "should handle seconds that create minutes" do
      d1 = Duration.new("00:7:30")
      d2 = Duration.new("00:7:45")
      (d1 + d2).value.should == 0.25
    end
  end
end
