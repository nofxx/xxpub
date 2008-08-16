require 'net/http'
mainp = Net::HTTP.new('localhost', 8000)
response, content = mainp.get('fuck.html', nil)
puts content