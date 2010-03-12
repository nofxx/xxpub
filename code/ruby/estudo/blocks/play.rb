#!/usr/bin/env ruby
puts "#\n# Blocks!\n#"

class Foobs

  def self.from_foo(&block)
    if block_given?
      puts "Block arity #{block.arity}"
    end
    yield rand(100)
  end

  def try_me
    yield self
  end

  def zoom!
    puts "Zoooom!"
  end

  def say(txt)
    puts "#{self} said #{txt}"
  end

  def transaction(&block)

  end
end


Foobs.from_foo { |x| p "Got #{x}" }

def foobs_for reason, &block
  puts "Want foobs for #{reason}"
  Foobs.from_foo(&block)
end


foobs_for :shooting do |f|
  puts "Shooting foob #{f}"
end

def foob(&block)
  Foobs.new.try_me(&block)
end

foob do |f|
  f.zoom!
  f.say :fubah
end
