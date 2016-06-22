FROM centos:7
COPY . /root/  
RUN curl -o alfresco.bin http://dl.alfresco.com/release/community/201605-build-00010/alfresco-community-installer-201605-linux-x64.bin && chmod 755 alfresco.bin && ./alfresco.bin --optionfile /root/install_opts && rm alfresco.bin
RUN chmod -R 777 /opt/alfresco/tomcat/webapps /opt/alfresco/tomcat/temp /opt/alfresco/tomcat/work /opt/alfresco/tomcat/logs /opt/alfresco/alf_data /opt/alfresco/tomcat/shared
EXPOSE 8080
VOLUME /opt/alfresco/alf_data
CMD cd /opt/alfresco/tomcat/logs && /opt/alfresco/java/bin/java -Djava.util.logging.config.file=/opt/alfresco/tomcat/conf/logging.properties -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Xms512M -Xmx7391M -XX:+DisableExplicitGC -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -Djava.awt.headless=true -Dalfresco.home=/opt/alfresco -Dcom.sun.management.jmxremote -XX:ReservedCodeCacheSize=128m -Djava.endorsed.dirs=/opt/alfresco/tomcat/endorsed -classpath /opt/alfresco/tomcat/bin/bootstrap.jar:/opt/alfresco/tomcat/bin/tomcat-juli.jar -Dcatalina.base=/opt/alfresco/tomcat -Dcatalina.home=/opt/alfresco/tomcat -Djava.io.tmpdir=/opt/alfresco/tomcat/temp org.apache.catalina.startup.Bootstrap start

