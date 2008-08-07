#!/usr/bin/env lua

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