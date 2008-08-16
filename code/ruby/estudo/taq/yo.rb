

# ||= ROX ... assign IF x == nil
#x = 5
x ||= 10
puts x



a = Array.new(10) { |n| n**n }
p a

a2 = a.select { |v| v%2==0 }.collect {|v| v + 1}
a3 = a.select { |v| v%2!=0 }
p a2
p a3

as = a.sort { |a,b| b <=> a }
p as

#ap = a.partition { |x| x < 10 }
#p ap

i = 1
#p i.methods

er = /^[0-9]/

p '1' =~ er
p '1' !~ er
p 'a' =~ er
p 'b' !~ er


p 'piccinini'.gsub(/cc/, "x")

f = File.open('teste.txt')
p f

f.grep(/s$/) do |fu|
  p fu
end

elevador = Proc.new { |x| p x**x }
elevador.call(3)

elevador = lambda { |x| p x+x }
elevador.call(11)

a = 1
b = 'b'

teste =
begin
  a + c + b
  a + c
rescue NameError => exc
  puts "Erro => #{exc}"
rescue TypeError => exc
 puts "Erro => #{exc}"
rescue StandardError => exc
  puts "Erro => #{exc}"
end

d = a + b rescue nil
p d