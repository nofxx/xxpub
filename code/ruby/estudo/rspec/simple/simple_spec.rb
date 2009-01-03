require File.expand_path(File.dirname(__FILE__) + '/simple')
include Simple

describe Carro do
  before do # :each => default,  :all 
    @car = Carro.new
  end
    
  it "should be rulzzz" do
    @car.should be_bacana #=> bacana?
  end
  
  it do
    @car.should_not be_an_instance_of(Motorista)
    @car.should be_an_instance_of(Carro)
  end
  
  it do
    @car.should have(4).rodas
  end
  
  it "should return a float in division to check with close_to" do
    @car.divisor(1).should be_close(4.33333333, 0.0000001)
  end

describe Motorista do
  
    before do # :each => default,  :all 
      @carro = mock(Carro)#, :ligar! => 1)
      @carro.stub!(:ligar).and_return(true)
      @motorista = Motorista.new(@carro)
    end
  
  it "should ligar o carro" do
    @motorista.ligar_carro.should be_true
  end
  
  # ORDEM INFLUI!! should receive -> action
  it "should ligar o carro 2" do
    @carro.should_receive(:ligar).and_return(true)
    @motorista.ligar_carro
  end

end
  
end