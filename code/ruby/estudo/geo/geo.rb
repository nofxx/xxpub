#!/usr/bin/env ruby
#require 'rubygems'
require 'ext/geo'
require 'benchmark'
include Math

# CONSTANTS
#
PI = 3.14159265358979
R = 6371
W = 0.5


# DEG 2 RAD
#
def deg2rad(d)
  (d/180.0) * PI
end
def rad2deg(r)
  (r*180.0) / PI 
end




def xdistancia(x1, y1, x2, y2)
  dlat = deg2rad(x2-x1)/2
  dlon = deg2rad(y2-y1)/2
  a = (sin(dlat) ** 2) + cos(deg2rad(x1)) * cos(deg2rad(x2)) * (sin(dlon) ** 2)
  b = 2 * atan2(sqrt(a), sqrt(1-a))
  c = R * b
  return c
end


  
#puts xdistancia(32.9697, -96.80322, 29.46786, -98.53506).to_s + " Km"
#puts xdistancia(31.9697, -96.80322, 29.46786, -98.53506).to_s + " Km"
#puts xdistancia(32.9697, -96.80322, 10.46786, -98.53506).to_s + " Km"

#R = 6371
#include Math
xPoint = Struct.new("Point", :x, :y)
def xwalker(p, ang)
 
  lat = p[:x]
  lon = p[:y]
  lat = deg2rad(lat); lon = deg2rad(lon); ang = deg2rad(ang)
  d = W/R.to_f 
  d = deg2rad(d)
  x = asin(sin(lat)*cos(d)+cos(lat)*sin(d)*cos(ang))
  y = lon+atan2(sin(ang)*sin(d)*cos(lat), cos(d)-sin(lat)*sin(x))
  y = (y+PI) % (2*PI) - PI
  x = rad2deg(x)
  y = rad2deg(y)
  puts x.to_s + " - " + y.to_s
  #Geo::Point.new(x,y)
  {
    :x => x,
    :y => y
  }
end

# GEO
#


#x1 = Geo::Line.new(1,1,2,2)
#x2 = Geo::Line.new(3,3,5,5)
#x3 = Geo::Line.new(5,5,9,9)

#g1 = Geo::LineSet.new
#g1 << x2
#g1 << x3
#g1._reindex

#x = LineSet.intersects?(Line)



# WALKERS
#



def hit
  r1 = Geo::Line.new(14.0,14.0,15.0,15.0)
  
 # r2 = Geo::Line.new(15,15,20,20)
  rota = Geo::LineSet.new
  rota << r1
  #rota << r2
  #rota._reindex
  g = 0
  #gps = Geo::Point.new(14.45, 14.45)
  gps = {
    :x => 14.47644,
    :y => 14.47645
  }
  catch :hit do
    while(g<360) do
      
      walk = xwalker(gps, g)#XX, YY, g)
      walker = Geo::Line.new(gps[:x], gps[:y], walk[:x], walk[:y])
      i = rota.intersects?(walker)
      puts "#{g}º -> " + i.to_s
      #throw :hit if i
      g+=45
    end
  end
end

puts "fiiiiiit =>> " + hit.to_s


puts "-----------------------------------"
#puts walkers



# BENCHMARK
#

m = 1000
puts "creating LineSet with #{m} lines"
#STDOUT.flush
ls = Geo::LineSet.new
m.times do |n|
#  l = Geo::Line.new(rand(1000), rand(1000), 1, 1)
#  l.abs = rand(20)
#  l.angle = rand * 2 * PI
  ls << Geo::Line.new(rand(1000), rand(1000), rand(1000), rand(1000))
end
#print "reindexing LineSet..."
#STDOUT.flush
ls._reindex
puts "done!"
l = Geo::Line.new(rand(1000), rand(1000), rand(1000), rand(1000))
Benchmark.benchmark("LineSet#intersects?(#{l.inspect})") do |bm|
  bm.report do
    ls.intersects?(l)
  end
end

