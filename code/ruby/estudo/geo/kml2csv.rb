require "rexml/document"
include REXML
kmlroot = (Document.new File.new "data.kml").root
nodes = kmlroot.elements.to_a("//Location")

begin
	f = File.open("data.csv", "w")
	f << "id,column1,column2,latitude,longitude\n"
	id = 1
	nodes.each { |node|
		column1 = node.elements["column1"].text
		column2 = node.elements["column2"].text
		coords = node.elements["Point"].elements["coordinates"].text.split(",")
		f << [id, column1, column2, coords[1], coords[0] ].join(",") << "\n"
		id += 1
	}
ensure
	f.close
end

# Parses a GoogleEarth KML file and writes the pertinent data to a CSV file

#<?xml version="1.0" encoding="UTF-8"?>
# <kml xmlns="http://earth.google.com/kml/2.0">
# <Folder>
# <name>Folder Name</name>
# <open>1</open>
# <ScreenOverlay>
# ... Screen Overlays
# </ScreenOverlay>
# <Document>
# <name>Document Name</name>
# <open>1</open>
# <Schema parent="Placemark" name="S_Parcel_centroids_SSSS">
# ... Schema Def ...
# </Schema>
# <Style id="khStyle722">
# ... Style Info ...
# </Style>
# <Folder id="layer 0">
# <name>FolderName</name>
# <Location>
# <name>Location name 1</name>
# <description><![CDATA[...Description text...]]></description>
# <styleUrl>#khStyle16037</styleUrl>
# <Point>
# <altitudeMode>relativeToGround
# <coordinates>-81.85829063169155,29.12257052899974,100</coordinates>
# </Point>
# <Column1>Column 1 data</Column1>
# <Column2>Column 2 data</Column2>
# </Location>
# <Location>
# <name>Location name 2</name>
# <description><![CDATA[...Description text...]]></description>
# <styleUrl>#khStyle16037</styleUrl>
# <Point>
# <altitudeMode>relativeToGround
# <coordinates>-81.85829063169155,29.12257052899974,100</coordinates>
# </Point>
# <Column1>Column 1 data</Column1>
# <Column2>Column 2 data</Column2>
# </Location>
# 
# ... More Locations ...
# </Folder>
# </Document>
# </Folder>
# </kml>
