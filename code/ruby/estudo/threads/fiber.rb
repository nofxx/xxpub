require "fiber"

fib = Fiber.new do
  x, y = 0, 1
  loop do
    Fiber.yield y
    x,y = y,x+y
  end
end

20.times { puts fib.resume }

f2 = Fiber.new do |value|
   puts "Estou em f2, transferindo para onde vai resumir ..."
   Fiber.yield value + 40
   puts "Cheguei aqui?"
end

f1 = Fiber.new do
   puts "Comecei f1, transferindo para f2 ..."
   f2.resume 10
end

puts "Resumindo fiber 1: #{f1.resume}"

produtor = Fiber.new do |cons|
   5.times do
      items = Array.new((rand*5).to_i+1,"oi!")
      puts "Produzidos #{items} ..."
      cons.transfer Fiber.current, items
   end
end

consumidor = Fiber.new do |prod,items|
   loop do
      puts "Consumidos #{items}"
      prod, items = prod.transfer
   end
end

# produtor.resume consumidor

f = g = nil

f = Fiber::Core.new { |x|
  puts "F1: #{x}"
  x = g.transfer(x+1)
  puts "F2: #{x}"
  x = g.transfer(x+1)
  puts "F3: #{x}"
}

g = Fiber::Core.new { |x|
  puts "G1: #{x}"
  x = f.transfer(x+1)
  puts "G2: #{x}"
  x = f.transfer(x+1)
}

f.transfer(100)
