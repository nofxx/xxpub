require 'spec_helper'

describe "Erl Foo" do

  describe "CMD" do
    before(:all) do
      @out = `./book`
    end

    it "should rn cline" do
      @out.should match(/foxxon/)
    end
 
    it "should rn cline" do
      @out.should match(/erl/)
    end    
    
    it "should call another func" do
      @out.should match(/more/)
    end
    
    it "should pass string to print" do
      @out.should match(/Rock/)
    end
  end
  
  # Not good, 1s per spec....
  # describe "-noshell" do
  #   def run(hsh)
  #     `erl -noshell -s #{hsh.keys} #{hsh.values} -s init stop`
  #   end
  #   
  #   it "should run" do
  #     run({:hi => :hihi}).should eql("\"Oi\"\r\nvc..\n")
  #   end

end