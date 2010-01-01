require 'spec_helper'

describe XC do
  
  before do
    @x = XC::Rock.new
  end
  
  it "should printout" do
    @x.putis("!").should be_nil
  end

  it "should xcat" do
    @x.xcat("fooxxx").should eql("fooxxxC")
  end
  
  it "should xcalc" do
    Xmath.xcalc(2).should be_close(5.3, 0.1)
  end

  it "should readbool" do
    Xmath.readbool(1).should be_false
    Xmath.readbool(11).should be_true
  end
  
  it "should dist" do
    Xmath.dist(10.7,5).should be_close(5.7, 0.01)
  end
  
  it "should ary" do
    Xmath.ary([3, "oi", true]).should eql([9, "OI", false])
  end
  
  
end