#!/usr/bin/env ruby

require 'hpricot'
require 'open-uri'
require 'rexml/document'
require 'erb'

#arg: url to parse from http://www.hotspringsenthusiast.com/TextLinks.asp
#doesnt work for arkansas, georgia, new york, north carolina, south dakota, virgina
url = ARGV[0]

#parse name of state out of url
state = url[url.index('.com')+5..url.length-5]

#grab the html
doc = Hpricot(open(url))

#create xml for the kml file
xml = REXML::Document.new
kml = xml.add_element 'kml', {'xmlns' => 'http://earth.google.com/kml/2.1'}
kml_doc = kml.add_element 'Document'

#add the name of the state to the xml
(kml_doc.add_element 'name').text = "#{state} Hot Springs"

#add reference to me
(kml_doc.add_element 'description').text = 'created by Benjamin Smith http://www.disjointthoughts.com'
doc_folder = kml_doc.add_element 'Folder'

#add reference to the data source
(doc_folder.add_element 'name').text = 'http://www.hotspringsenthusiast.com/'
(doc_folder.add_element 'description').text = "data source #{url}"

#iterate over the rows in the table
doc.search('//tr').each do |tr|  
  tds = tr.search('//td')
  if tds.first.inner_html != 'STATE'
    link = tds[3].search('//a').to_s
    lat = link[link.index('lat=')+4..link.index('&',link.index('lat='))-1]
    lon = link[link.index('lon=')+4..link.index('"',link.index('lon='))-1].gsub('E','')
    topo = link[link.index('href="')+6..link.index('"',link.index('href="')+7)-1] 
    
    placemark = doc_folder.add_element 'Placemark'
    (placemark.add_element('name')).text = tds[3].search('//a').inner_html.to_s.gsub("\r\n",'').squeeze.downcase
    (placemark.add_element('description')).text = REXML::CData.new('Temperature: '+tds[4].inner_html+'F/'+tds[5].inner_html+'C<br/><a href="'+topo+'">Topo</a>')
    point = placemark.add_element 'Point'
    (point.add_element 'coordinates').text = "#{lon.to_s},#{lat.to_s}"
  end  
end

f = File.new("#{state.downcase}.kml",'w')
f.write('<?xml version="1.0" encoding="UTF-8"?>'+"\n")
xml.write(f,4)
f.close

#create html file to display kml in google map
erb = ERB.new(File.read('template_hot_springs.erb'))
f = File.new("#{state.downcase}_hot_springs.html",'w')
f.write(erb.result(binding))
f.close