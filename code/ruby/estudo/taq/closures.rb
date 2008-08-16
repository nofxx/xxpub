def gimme 
  if block_given? 
    yield    
    yield
  else 
    puts "I'm blockless!" 
  end 
end 


gimme     

gimme {  puts "x" }   
       
def return_block 
  yield 
end 
def return_proc(&proc ) 
  yield 
end 
return_block { puts "Got block!" } 
return_proc { puts "Got block, convert to proc!" } 
             
c = lambda { |i| puts i }

class Test
  def say(block)
    block.call(self.class)
  end
end

c.call(self.class) # => Object
Test.new.say(c)    # => Test

count =Proc.new { [1,2,3,4,5].each do |i| print i end; 
puts } 
your_proc =lambda { puts "Lurch: 'You rang?'" } 
my_proc =proc { puts "Morticia: 'Who was at the door, 
Lurch?'" } 
# What kind of objects did you just create? 
puts count.class, your_proc.class, my_proc.class


puts '---------------------------------------------------------'
# .call(x) == [x]

def metodo_recebe_block ( &block )
  localvar = 10
  block.call("aqui dentro")
end

localvar = 20
localblock = Proc.new { |where| puts "Block called from #{where}. Local variable is #{localvar}" }

localblock.call("aqui fora")
metodo_recebe_block( &localblock )

def metodo_retorna_block x
  valor = x * 10
  return Proc.new { puts "Valor de X: #{x}, o outro #{valor}"}
end

block = metodo_retorna_block 5
block.call