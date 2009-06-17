# -*- coding: utf-8 -*-

hal = "Keep on rocking"
ascii = hal.unpack("C*")
p ascii
# We can’t use Array#each since we can’t mutate a Fixnum
ascii.map! { |i| i + 6 }
p ascii
puts  ascii.pack("C*")


order = ascii.map! {|x| x-6 }
puts order.pack("C*")

# Base 64

b64 = "Teste".unpack("m*")
p b64
p b64.pack("m*")
