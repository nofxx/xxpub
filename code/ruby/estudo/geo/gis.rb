def self.deg2rad(deg)
	(deg * Math::PI / 180)
end

def self.rad2deg(rad)
	(rad * 180 / Math::PI)
end

def self.acos(rad)
	Math.atan2(Math.sqrt(1 - rad**2), rad)
end

def self.distance_in_miles(loc1, loc2)
	lat1 = loc1.latitude
	lon1 = loc1.longitude
	lat2 = loc2.latitude
	lon2 = loc2.longitude
	theta = lon1 - lon2
	
	dist = Math.sin(self.deg2rad(lat1)) * Math.sin(deg2rad(lat2)) 
		+ Math.cos(self.deg2rad(lat1)) * Math.cos(self.deg2rad(lat2)) * Math.cos(deg2rad(theta))
	
	dist = self.rad2deg(self.acos(dist))
	
	(dist * 60 * 1.1515).round #distance in miles
end

def miles_to(location)
	Location.distance_in_miles(self, location)
end

def self.locationArea(location, miles)
	radius = miles.to_f
	latR = radius / ((6076 / 5280) * 60)
	lonR = radius / (((Math.cos(location.latitude * Math::PI / 180) * 6076) / 5280) * 60)
	
	{
		:min_latitude => location.latitude - latR,
		:min_longitude => location.longitude - lonR,
		:max_latitude => location.latitude + latR,
		:max_longitude => location.longitude + lonR
	}
end

def self.location_ids_in_range(location, miles)
	la = Location.locationArea(location, miles)
	Location.find(:all,
		:select => "locations.id",
		:conditions => ["locations.latitude <= ? and locations.latitude >= ? " + \
			" AND locations.longitude >= ? and locations.longitude <= ?",
			la[:max_latitude], la[:min_latitude], la[:min_longitude], la[:max_longitude]
		]
	).collect { |l| l.id }
end

def self.locations_in_range(location, miles)
	la = Location.locationArea(location, miles)
	Location.find(:all,
		:conditions => ["locations.latitude <= ? and locations.latitude >= ? " + \
			" AND locations.longitude >= ? and locations.longitude <= ?",
			la[:max_latitude], la[:min_latitude], la[:min_longitude], la[:max_longitude]
		]
	)
end