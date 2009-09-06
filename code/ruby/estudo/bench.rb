require 'benchmark'

# FAILS 1.9.1  times &s
# b n, lambda{ }, lambda{ } ...
# def b(*stuff)
#   rep, stuff = stuff.partition{ |s| s.kind_of? Numeric }
#   rep.length ||= [1_000_000]
#   rep.each do |r|
#     puts "\n                         Running #{r} times"
#     Benchmark.bmbm do |b|
#       stuff.each { |s| b.report(s.to_s) { r.times &s } }
#     end
#   end
#   "-----------------------------------------"
# end


def fact(n)
  return 1 if n == 0
  (1..n).inject { |a,b| a*b }
end

def rfact(n)
  return 1 if n == 0
  n * fact(n-1)
end


#b 1000, lambda { fact(1000) }, lambda { rfact(1000) }

Benchmark.bmbm do |b|
  b.report("fact") { 1000.times { fact(1000) } }
  b.report("rfact") { 1000.times { rfact(1000) } }
end

# 1.8.7 => 3.01
# 1.9.1 => 2.23
# jruby => 2.08
