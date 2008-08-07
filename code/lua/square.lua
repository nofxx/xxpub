#!/usr/bin/env lua
-- Comments.....
-- 

function nofxx(x)
  return x*x+x
end

print "Calculadora"
  
print "numero:"
n = io.read("*numb")
print(nofxx(n))