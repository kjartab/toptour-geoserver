FROM tomcat:8.0.42-jre8-alpine

ENV GEOSERVER_DATA_DIR /var/local/geoserver
ENV GEOSERVER_INSTALL_DIR /usr/local/geoserver

RUN mkdir $GEOSERVER_DATA_DIR
RUN mkdir $GEOSERVER_INSTALL_DIR

ENV GEOSERVER_PLUGIN vectortiles
ENV GEOSERVER_VERSION 2.11.0

RUN apk add --update openssl unzip 


#ADD conf/geoserverweb.xml /usr/local/tomcat/webapps/geoserver/WEB-INF/web.xml
ADD conf/geoserverweb.xml /usr/local/tomcat/conf/Catalina/localhost/geoserver.xml

RUN cd ${GEOSERVER_INSTALL_DIR} \
    && wget http://sourceforge.net/projects/geoserver/files/GeoServer/${GEOSERVER_VERSION}/geoserver-${GEOSERVER_VERSION}-war.zip \
    && unzip geoserver-${GEOSERVER_VERSION}-war.zip \
    && unzip geoserver.war \
    && rm -rf geoserver-${GEOSERVER_VERSION}-war.zip geoserver.war target *.txt

#ADD conf/geweb.xml ${GEOSERVER_INSTALL_DIR}/WEB-INF/web.xml


# Download and install geoserver vector tiles plugin
RUN wget https://sourceforge.net/projects/geoserver/files/GeoServer/${GEOSERVER_VERSION}/extensions/geoserver-${GEOSERVER_VERSION}-${GEOSERVER_PLUGIN}-plugin.zip -O /tmp/${GEOSERVER_PLUGIN}-plugin.zip

RUN unzip -q /tmp/${GEOSERVER_PLUGIN}-plugin.zip -d ${GEOSERVER_INSTALL_DIR}/WEB-INF/lib/ \
    && rm /tmp/${GEOSERVER_PLUGIN}-plugin.zip


# Tomcat environment
ENV CATALINA_OPTS "-server -DGEOSERVER_DATA_DIR=${GEOSERVER_DATA_DIR}"
