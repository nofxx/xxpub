class Carro

  def bacana?
    true
  end
  
  def contador
    5
  end
  
  def somador(x)
    x + 5
  end
  
  def rodas
    ['Direita', 'Esquerda', 'Direita', 'Esquerda']
  end
  
end

class Livro; end

describe Carro do

  before do # :each => default,  :all 
    @car = Carro.new
  end
    
  it "should be rulzzz" do
    @car.should be_bacana #=> bacana?
  end
  
  it do
    @car.should be_bacana
  end
  
  it do
    @car.should_not be_an_instance_of(Livro)
  end
  
  it do
    @car.should have(4).rodas
  end
  
  it "should receive somador" do
    @car.should_receive(somador).with(5)
  end
  
  it "should receive contador" do
    @car.should_receive(:contador).and_return(5)
  end

  
end