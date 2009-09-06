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

def login_gen(phrase)
  Proc.new { |name| "#{phrase}, #{name}" }
end

noon = login_gen("afternoon")
puts noon.call("nofxx")

print "(t)imes or (p)lus: "
times = "t" #gets
print "number: "
number = Integer(10)
if times =~ /^t/
    calc = lambda {|n| n*number }
else
    calc = lambda {|n| n+number }
end
puts((1..10).collect(&calc).join(", "))

WORDS = %w(Jane, aara, multiko)

def map_wrong
  p WORDS.map(&:upcase)
rescue => e
  p "Symbol#to_proc not defined => #{e}"
end
map_wrong

class Symbol

    # A generalized conversion of a method name
    # to a proc that runs this method.
    #
    def to_proc
        lambda {|x, *args| x.send(self, *args)}
    end

end

# Viola !
p upcase_words = WORDS.map(&:upcase)


def some_method( arg )
  rand(10).times{ puts arg }
end
m = method :some_method
m.arity #=> 1
m.call( 10 ) # => calls the method

class Test
  @var = 10
  def self.var
    @var
  end
end

Test.var # => 10
Test::var # => 10
# Test.new.var # => NoMethodError: undefined method `var' for #


def test_yield(v1, &v2)
  yield
  yield v1
end

test_yield "ff" do |x|
  puts "hi #{x}"
end


class NumericSequences
   def fibo(limit)
     i = 1
     yield 1
     yield 1
     a = 1
     b = 1
     while (i < limit)
         t = a
         a = a + b
         b = t
         yield a
         i = i+1
     end
   end

   def fact(n)
    return 1 if n == 0
    (1..n).inject { |a,b| a*b }
  end

# def fact(limit)
#   raise ArgumentError, 'argument must be a non-negative integer' unless limit.is_a?(Integer) && limit >= 0
#   (1..limit).inject(1, :*)
# end


  def pascal_triangle_row(n)
     for k in 0..n
          yield(fact(n)/(fact(k)*fact(n-k)))
     end
  end
end
g = NumericSequences::new

(0..8).each {|n| g.pascal_triangle_row(n) {|r| print "#{r} "}; print "\n"}
