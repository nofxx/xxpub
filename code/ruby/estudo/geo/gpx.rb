#!/usr/bin/env ruby
=begin
    Andrew Turner, ruby distance calculation
    Copyright (C) 2005 Andrew Turner

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

   Please send patches / bug reports to andrew@highearthorbit.com

=end

require 'rexml/document'
include REXML

class Geo
  def self.deg2rad(deg)
  	(deg * Math::PI / 180)
  end

  def self.rad2deg(rad)
  	(rad * 180 / Math::PI)
  end

  def self.abs(x)
        if x >= 0
            x
        else
            -x
        end
  end

  def self.acos(rad)
  	Math.atan2(Math.sqrt(abs(1 - rad**2)), rad)
  end

  def self.distance_in_km(lat1, lon1, lat2, lon2)
  	theta = lon1 - lon2

  	dist = Math.sin(self.deg2rad(lat1)) * Math.sin(deg2rad(lat2)) + Math.cos(self.deg2rad(lat1)) * Math.cos(self.deg2rad(lat2)) * Math.cos(deg2rad(theta))

  	dist = self.rad2deg(self.acos(dist))

  	(dist * 60.0 * 1.1515 * 1.609344) #distance in km
  end
end

if(!ARGV[0])
   STDERR.puts "usage: gpx.rb track1.gpx track2.gpx ..."
   exit 0
end

ARGV.each do |gpxfile|
  file = File.new( gpxfile )
  doc = Document.new file

  distance = 0
  total = 0
  segment = 0

  doc.elements.each('gpx/trk/trkseg') do |e|

    first = true

    oldlon = 0.0
    oldlat = 0.0
    segment += 1

    e.elements.each('trkpt') do |pt|
      lat = pt.attributes['lat'].to_f
      lon = pt.attributes['lon'].to_f
    
      if first
        first = false
      else
        distance = distance + Geo.distance_in_km(lat, lon, oldlat, oldlon)
      end
      oldlon = lon
      oldlat = lat 
    end

    printf("#{file.path} Segment %d: %.2f km\n", segment, distance)

    total += distance
    distance = 0

  end

  printf("#{file.path} Total: %.2f km\n", total)

end
