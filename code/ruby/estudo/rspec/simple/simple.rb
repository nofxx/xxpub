module Simple
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
    
    def divisor(x)
      10.0 / 3 + x
    end
  
    def ligar
      true
    end
  
    def rodas
      ['Direita', 'Esquerda', 'Direita', 'Esquerda']
    end
  
  end

  class Motorista
  
    def initialize(carro)
      @carro = carro
    end
  
    def ligar_carro
      @carro.ligar
    end
  
  end
end