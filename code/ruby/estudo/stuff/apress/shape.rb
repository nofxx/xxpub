class Shape
  def mshape
    #puts "pshape"
  end
end
 
class Square < Shape
  def initialize(tam_lado)
    @@n = defined?(@@n) ? @@n + 1 : 1
    @tam_lado = tam_lado
  end
  
  def Square.conta
    @@n
  end
  
  def area
    @tam_lado * 2
  end
  
  def perimetro
    @tam_lado * 4
  end
end

class Triangle < Shape
  def initialize(base_width, height, side1, side2, side3)
    @base_width = base_width
    @height = height
    @side1 = side1
    @side2 = side2
    @side3 = side3
  end

  def area
    @base_width * @height / 2
  end
  
  def perimeter
    @side1 + @side2 + @side3
  end
end

a = Square.new(10)
b = Square.new(5)
c = Square.new(20)

#puts c.mshape
puts b.area, '--'
puts b.mshape, '--'
puts Square.conta