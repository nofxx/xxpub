require 'rubygems'
require 'erlectricity'

receive do |f|
  f.when([:echo, String]) do |text|
    f.send!([:result, "You said text: #{text}"])
    f.receive_loop
  end

  f.when([:echo, Fixnum]) do |num|
    f.send!([:result, "You said num: #{num}"])
    f.receive_loop
  end

  f.when([:echo, Array]) do |num|
    f.send!([:result, "You said num: #{num}"])
    f.receive_loop
  end
end
