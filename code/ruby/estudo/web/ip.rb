require 'ipaddr'


ip = '183.12.45.42'
ip6 = 'fe80::fcfd:43ff:fe12:d079'
mask = 8
mask6 = 64


valid_ip = IPAddr.new(ip)
valid_ip.mask(mask)

valid_ip6 = IPAddr.new(ip6)
valid_ip6.mask(mask6)
                               
IPAddr.new(2)


puts valid_ip
puts valid_ip.family
puts valid_ip.to_i
puts valid_ip.hton
puts valid_ip.ipv4_compat         
puts valid_ip.ipv4_mapped 

puts valid_ip.native       

puts "\n # IPV6 \n\n"

puts valid_ip6      
puts valid_ip6.ipv6?  
puts valid_ip6.family
puts valid_ip6.to_i
puts valid_ip6.hton # => 
puts valid_ip6.ip6_arpa # => 
puts valid_ip6.ip6_int # =>     
puts valid_ip6.ipv4_compat?       
puts valid_ip6.native    

trin = valid_ip6.to_s         
puts IPAddr.new(trin)           
puts IPAddr.new(trin)    

#puts valid_ip6.ipv4_mappped?     