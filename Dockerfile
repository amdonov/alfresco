FROM debian:jessie
RUN apt-get update && apt-get install -y curl
COPY install_opts /root/install_opts
RUN curl -k -o alfresco.bin http://dl.alfresco.com/release/community/5.0.d-build-00002/alfresco-community-5.0.d-installer-linux-x64.bin && chmod 755 alfresco.bin && ./alfresco.bin --optionfile /root/install_opts && rm alfresco.bin
# Allow Alfresco's tomcat to run as any UID for Openshift
RUN chmod -R 777 /opt/alfresco/tomcat/webapps /opt/alfresco/tomcat/temp /opt/alfresco/tomcat/work /opt/alfresco/tomcat/logs /opt/alfresco/alf_data
EXPOSE 8080
VOLUME /opt/alfresco/alf_data
CMD /opt/alfresco/tomcat/startup.sh && tail -f /opt/alfresco/tomcat/logs/catalina.out
