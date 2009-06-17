sum = lambda do |f,a,b|
  s = 0 ; a.upto(b){|n| s += f.(n) } ; s
end

puts sum.(lambda{|x| x},1,5) #=> 15
puts sum.(lambda{|x| x**2},1,5) #=> 55
puts sum.(lambda{|x| 2**x},1,5) #=> 62

# generate the currying
currying = sum.curry

# Generate the partial functions
sum_ints = currying.(lambda{|x| x})
sum_of_squares = currying.(lambda{|x| x**2})
sum_of_powers_of_2 = currying.(lambda{|x| 2**x})

puts sum_ints.(1,5) #=> 15
puts sum_of_squares.(1,5) #=> 55
puts sum_of_powers_of_2.(1,5) #=> 62
