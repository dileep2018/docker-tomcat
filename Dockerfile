FROM 1science/java:oracle-jre-8

MAINTAINER Julien Plu <julien.plu@redaction-developpez.com>
 
ENV TOMCAT_MAJOR_VERSION=8 \
    TOMCAT_MINOR_VERSION=8.0.33 \
    CATALINA_HOME=/usr/local/tomcat \
    PATH=$CATALINA_HOME/bin:$PATH \
    MAX_HEAP_SIZE_MB=1024

RUN mkdir -p "$CATALINA_HOME" \
    && wget https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz \
    && tar zxf apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz \
    && rm -f apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz \
    && mv apache-tomcat-${TOMCAT_MINOR_VERSION}/* /usr/local/tomcat/ \
    && rmdir apache-tomcat-${TOMCAT_MINOR_VERSION} \
    && rm -rf /usr/local/tomcat/webapps/examples \
    && rm -rf /usr/local/tomcat/webapps/docs \
    && rm -f /usr/local/tomcat/bin/*.bat

ENV PATH=$CATALINA_HOME/bin:$PATH \
    CATALINA_OPTS="$CATALINA_OPTS -Xmx${MAX_HEAP_SIZE_MB}m"

COPY config/tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml

VOLUME ["/usr/local/tomcat"]

EXPOSE 8080

CMD ["catalina.sh", "run"]
