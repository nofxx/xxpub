#!/usr/bin/env lua
-- Comments.....
-- Lua !
--

function triple(x)
  return x*x+x
end

print "Calculadora"

print "N:"
n = io.read("*numb")
print("Result => " .. triple(n))

function maximum(a)
   local mi = 1          -- maximum index
   local m = a[mi]       -- maximum value
   for i,val in ipairs(a) do
      if val > m then
         mi = i
         m = val
      end
   end
   return m, mi
end

print(maximum({8,10,23,12,5}))     --> 23   3
