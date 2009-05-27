#!/usr/bin/env lua
dofile("xlib.lua")

--numeros sao floas
print(2+2)
z = 2.7
x = 10
y = nil

ab = true

print(z)
print(x)
print(x+10)

x = "bla bla"

print(type(z))
print(type(x))
print(type(y))


text = "Mutxo belo"
print(text .. "eh a vida")
mais = text .. "eh sim"
print (mais)



marray = { valor = 10, rock = "roll" }

print(marray)
print(marray.valor)
print(marray.rock)

print(type(marray))
-- functions

function foo()
  print("oi")
end

function fxx(a)
  print(a)
end



foo()
fxx("-----------------------------------")


x = 5

do
  local x=x
  print(x)
  x=x+2
  print(x)
  do
    local x=x+4
    print(x)
  end
  do
    x=x*10
    print(x)
  end
  print(x)
end
print(x)

-- from do file

-- just a - to in/out..cool
---[[
print(norm(2,3))
--]]

print(arg[0])
print(arg[1])

print(type("Hello world"))  --> string
print(type(10.4*3))         --> number
print(type(print))          --> function
print(type(type))           --> function
print(type(true))           --> boolean
print(type(nil))            --> nil
print(type(type(X)))        --> string
print(type(a))   --> nil   (`a' is not initialized)
a = 10
print(type(a))   --> number
a = "a string!!"
print(type(a))   --> string
a = print        -- yes, this is valid!
a(type(a))       --> function

print(tostring(10))   --> true
print(10 .. "")       --> true

-- Tables

a = {}     -- create a table and store its reference in `a'
k = "x"
a[k] = 10        -- new entry, with key="x" and value=10
a[20] = "great"  -- new entry, with key=20 and value="great"
print(a["x"])    --> 10
k = 20
print(a[k])      --> "great"
a["x"] = a["x"] + 1     -- increments entry "x"
print(a["x"])    --> 11
-- cool way
a.x = a.x + 1
print(a.x)

a[1] = "teste"
a[2] = "testoio"

-- print the lines
for i,line in ipairs(a) do
   print(line)
end

print(4 and 5)         --> 5
print(nil and 13)      --> nil
print(false and 13)    --> false
print(4 or 5)          --> 4
print(false or 5)      --> 5

-- Quais hash
a = {x=0, y=0} -- => a = {}; a.x = 0 ......
polyline = {color="blue", thickness=2, npoints=4,
   {x=0, y=0},
   {x=-10, y=0},
   {x=-10, y=1},
   {x=0,   y=1}
}

print(polyline)
weird =    {x=10, y=45; "one", "two", "three"}

-- print the lines
for i,line in ipairs(weird) do
   print(line)
end
