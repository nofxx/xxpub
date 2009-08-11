require 'rubygems'
require 'ffi'
#require 'mylibrary'
module MyLibrary
  extend FFI::Library
  ffi_lib(File.expand_path(File.dirname(__FILE__).gsub(".","") + "main.so"))
  attach_function :calculate_something, [:int, :float], :double
  attach_function :error_code, [], :int # note empty array for functions taking zero arguments
  attach_function :create_object, [:string], :pointer
  attach_function :calculate_something_else, [:double, :pointer], :double
  attach_function :free_object, [:pointer], :void
end


c = MyLibrary.calculate_something(42, 98.6) # note FFI handles literals just fine
if ( (errcode = MyLibrary.error_code()) != 0)
  puts "error calculating something: #{errcode}"
  exit 1
end

objptr = MyLibrary.create_object("my object") # note FFI handles string literals as well
d = MyLibrary.calculate_something_else(c, objptr)
MyLibrary.free_object(objptr)

puts "calculated #{d}"
