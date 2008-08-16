#puts Object::constants
#puts Object::methods
#puts IO::methods
#puts IO::class_variables
include Math

class Fxx
  
  def initialize
    @x = 10
  end
  
  def teste( x )
    unless x.respond_to? :include?
      raise ArgumentError,
        "Classe n suportada -> #{ x.class }"
    end
    x = x.dup
    puts x.class
  end
end

class String
   def dash_split
     self.split( '-' )
   end
end
puts "oi-boi".dash_split

x = Fxx.new
x.teste("kd")
#puts Fxx::methods

catsa = [0.12, 0.63, 0.09].collect { |catcost| catcost + ( catcost * 0.20 ) }

puts catsa

x = [10,30]
y = [5,20]

z = x-y
puts z
def deg2rad(degrees)
  degrees.to_f / 180.0 * Math::PI
end
      
def rad2deg(rad)
  rad.to_f * 180.0 / Math::PI 
end

KM = 1.609344

def acos(rad)
	Math.atan2(Math.sqrt(1 - rad**2), rad)
end

def xdistancia(lat1, lon1, lat2, lon2, *un)
  theta = lon1 - lon2
  #dist = sin(deg2rad(lat1)) * sin(deg2rad(lat2)) + cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * cos(deg2rad(theta))
  dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2)) 
  	+ Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.cos(deg2rad(theta))
	dist = rad2deg(acos(dist))
  miles = dist * 60 * 1.1515
  return miles.round
end


def locationArea(location, miles)
	radius = miles.to_f
	latR = radius / ((6076 / 5280) * 60)
	lonR = radius / (((cos(location.latitude * PI / 180) * 6076) / 5280) * 60)
	{
		:min_latitude => location.latitude - latR,
		:min_longitude => location.longitude - lonR,
		:max_latitude => location.latitude + latR,
		:max_longitude => location.longitude + lonR
	}
end

# Classes and objects in Ruby are rather straigthforward
class Person
    # Class variables (also called static attributes) are prefixed by @@
    @@person_counter=0
    
    # object constructor
    def initialize(age, name, alive = true)     # Default arg like in C++
        @age, @name, @alive = age, name, alive  # Object attributes are prefixed by '@'
        @@person_counter += 1
          # There is no '++' operator in Ruby. The '++'/'--'  operators are in fact 
          # hidden assignments which affect variables, not objects. You cannot accomplish
          # assignment via method. Since everything in Ruby is object, '++' and '--' 
          # contradict Ruby OO ideology. Instead '-=' and '+=' are used.
    end
    
    attr_accessor :name, :age   # This creates setter and getter methods for @name
                                # and @age. See 13.3 for detailes.
    
    # methods modifying the receiver object usually have the '!' suffix
    def die!
        @alive = false
        puts "#{@name} has died at the age of #{@age}."
        @alive
    end
    
    def kill(anotherPerson)
        print @name, ' is killing ', anotherPerson.name, ".\n"
        anotherPerson.die!
    end

    # methods used as queries
    # usually have the '?' suffix    
    def alive?
        @alive && true
    end
    
    def year_of_birth
        Time.now.year - @age
    end
    
    # Class method (also called static method)
    def Person.number_of_people
        @@person_counter
    end
end

# Using the class:
# Create objects of class Person
lecter = Person.new(47, 'Hannibal')
starling = Person.new(29, 'Clarice', true)
pazzi = Person.new(40, 'Rinaldo', true)

# Calling a class method
print "There are ", Person.number_of_people, " Person objects\n"

print pazzi.name, ' is ', (pazzi.alive?) ? 'alive' : 'dead', ".\n"
lecter.kill(pazzi)
print pazzi.name, ' is ', (pazzi.alive?) ? 'alive' : 'dead', ".\n"

print starling.name , ' was born in ', starling.year_of_birth, "\n"

#puts acos(0.6)

def self.acos(rad)
	Math.atan2(Math.sqrt(1 - rad**2), rad)
end


def dec2bin(n)
    [n].pack("N").unpack("B32")[0].sub(/^0+(?=\d)/, '')
end

def bin2dec(n)
    [("0"*32+n.to_s)[-32..-1]].pack("B32").unpack("N")[0]
end

#puts acos(0.6)

#puts deg2rad(330)
#puts rad2deg(6)