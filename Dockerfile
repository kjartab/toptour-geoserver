FROM tomcat:8.0.42-jre8-alpine

ENV GEOSERVER_DATA_DIR=/geoserver_data
# RUN mkdir $GEOSERVER_DATA_DIR

ENV GEOSERVER_PLUGIN vectortiles
ENV GEOSERVER_VERSION 2.11.0

RUN apk add --update openssl unzip 

WORKDIR $CATALINA_HOME

# Download and install geoserver
RUN wget http://sourceforge.net/projects/geoserver/files/GeoServer/${GEOSERVER_VERSION}/geoserver-${GEOSERVER_VERSION}-war.zip -O /tmp/geoserver.zip

RUN unzip -q /tmp/geoserver.zip -d /tmp \
 	&& unzip -q /tmp/geoserver.war -d $CATALINA_HOME/webapps/geoserver \
	&& rm -rf $CATALINA_HOME/webapps/geoserver/data \
    && rm /tmp/geoserver.war \
	&& rm /tmp/geoserver.zip

# Download and install geoserver vector tiles plugin
RUN wget https://sourceforge.net/projects/geoserver/files/GeoServer/${GEOSERVER_VERSION}/extensions/geoserver-${GEOSERVER_VERSION}-${GEOSERVER_PLUGIN}-plugin.zip -O /tmp/${GEOSERVER_PLUGIN}-plugin.zip

RUN unzip -q /tmp/${GEOSERVER_PLUGIN}-plugin.zip -d $CATALINA_HOME/webapps/geoserver/WEB-INF/lib/ \
	&& rm /tmp/${GEOSERVER_PLUGIN}-plugin.zip

COPY conf/web.xml /usr/local/tomcat/conf/web.xml

#RUN mkdir $GEOSERVER_DATA_DIR/workspaces
#COPY backup/geoserver_data/workspaces/toptour $GEOSERVER_DATA_DIR/workspaces/toptour
