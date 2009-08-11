#!/usr/bin/ruby
# eav6999
module Memoize
  def remember(name)
    # orig = "orig_#{name}"
    # alias_method orig, name
    orig = instance_method(name)
    memory = {}

    define_method(name) do |*args|
      if memory.has_key?(args)
        memory[args]
      else
        bound = orig.bind(self)
        # send orig, *args
        memory[args] = bound.call(*args)
      end
    end
  end
end

module SuperMemoize
  def remember(name, &block)
    define_method(name, &block)
    orig = instance_method(name)
    memory = {}

    define_method(name) do |*args|
      if memory.has_key?(args)
        memory[args]
      else
        bound = orig.bind(self)
        # send orig, *args
        memory[args] = bound.call(*args)
      end
    end
  end
end

class Expensive
  extend Memoize

  def discount(*skus)
    #meth not NIL!!!
    expensive_calc(*skus)
  end
  remember :discount

  private

  def expensive_calc(*skus)
    puts "Run..."
    skus.inject { |m,n| m + n }
  end
end
class SuperExpensive
  extend SuperMemoize

  remember :discount do |*skus|
    expensive_calc(*skus)
  end

  private

  def expensive_calc(*skus)
    puts "Run..."
    skus.inject { |m,n| m + n }
  end
end

e = Expensive.new
p e.discount(1,2,3)
p e.discount(1,2,3)

e = SuperExpensive.new
p e.discount(1,2,3)
p e.discount(1,2,3)
