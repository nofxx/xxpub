require 'rubygems'
require 'erlectricity'

receive do |f|
  f.when([:speak, Any]) do |comment|
    puts comment
    f.receive_loop
  end
 
  f.when([:paste, Any]) do |comment|
    puts comment #room.paste(comment)
    f.receive_loop
  end
 
  f.when(Any) do |obj|
    p obj
  end
end
