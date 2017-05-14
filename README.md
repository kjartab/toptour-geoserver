## Toptour Geoserver

### Docker Geoserver


https://developer.atlassian.com/blog/2015/08/minimal-java-docker-containers/




## Build the container
docker build -t "test/test" .


## Run container detatched

docker run -d "test/test" -p 8080:8080 -v /src/webapp:/webapp

## SSH into container

docker run -it "test/test" /bin/sh



----------------

docker build -t "toptour/geo" ./

docker run -d  -p 8080:8080  -v /vagrant/toptourcollection/toptour-geoserver/geodata:/geoserver_data "toptour/geo"

docker run -d  -p 8080:8080  -v /vagrant:/webapp "toptour/geo"

docker exec -it 5e3c9cfe2a95 /bin/sh







http://localhost/geoserver/slippymap/streets/13/4390/2854.pbf?buffer=5&styles=line

http://localhost:8282/geoserver/toptour/toptour:turer/13/4390/2854.pbf?styles=line



http://www.webatlas.no/maptiles/tiles/webatlas-gray-vektor/wa_grid/7/67/34.png



http://localhost:8282/geoserver/gwc/service/tms/1.0.0/toptour:turer@EPSG:900913@pbf/{z}/{x}/{y}.pbf

http://localhost:8282/geoserver/gwc/service/tms/1.0.0/toptour:turer@EPSG:900913/{z}/{x}/{y}.png


http://localhost:8282/geoserver/gwc/service/tms/1.0.0/toptour:turer@EPSG:900913/7/270/138.png


Trondheim tile


== Tile Boundaries ==
WGS84 datum (longitude/latitude):
8.4375 62.915233039476135
11.25 64.16810689799152

Spherical Mercator (meters):
939258.2035682462 9079495.967826378
1252344.271424327 9392582.035682458

Pixels at zoom 7:
17152 8704 17408 8960


http://localhost:8282/geoserver/toptour/wms?SERVICE=WMS&VERSION=1.1.1&REQUEST=GetMap&FORMAT=image%2Fpng&TRANSPARENT=true&STYLES&LAYERS=toptour%3Aturer&SRS=EPSG%3A404000&WIDTH=769&HEIGHT=472&BBOX=-17.947265625000007%2C40.8076171875%2C49.58789062500001%2C82.2392578125




------
Need 

insert into utno.eturer
select id, attribs->'navn'::text, attribs->'beskrivelse'::text, geom from utno.turer 
  WHERE (turer.attribs -> 'tags'::text) ? 'Skitur'::text AND st_length(turer.geom::geography, true) < 40000::double precision
