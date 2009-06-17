require 'rubygems'
require 'spec'

class Hash
  def method_missing(m,v = nil)
    v ? self[m] = v : self[m]
  end
end






describe "luahash" do
  before(:each) do
    @h = { :a => 1, :rock => 2, :x => 8}
  end

  it "should work" do
    @h.a.should eql(1)
  end

  it "should set too" do
    @h.coisa_nova 45
    @h.coisa_nova.should eql(45)
  end
end
