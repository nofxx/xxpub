class Nada
  def initialize
    @arr = Array.new
    @point = 0.0
  end
  
  def add(obj)
    @arr.push(obj)
  end
  
  def arr
    @arr
  end
  
  def somero(y)
    @point + y
  end
  
  def point
    @point
  end
    
end