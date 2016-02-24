##
# borrowed liberally from chilcano/wso2am
##

FROM klousiaj/oracle-java:7.79
MAINTAINER J.P. Klousia <klousiaj>

ENV WSO2_BUNDLE_NAME wso2am-1.10.0
ENV WSO2_FOLDER_NAME wso2am
ENV WSO2_PORT_OFFSET 0

# expose the necessary ports to run the API Manager
EXPOSE 9443 9763 8280 8243 7711 10397

# move the file onto the container so it can be unzipped
RUN wget -q --no-check-certificate -P /opt https://www.dropbox.com/s/82yc9brsfey69ep/wso2am-1.10.0.zip; \
  unzip /opt/$WSO2_BUNDLE_NAME.zip -d /opt/ > /opt/${WSO2_FOLDER_NAME}.listfiles; \
  mv /opt/${WSO2_BUNDLE_NAME} /opt/${WSO2_FOLDER_NAME}; \
  rm /opt/${WSO2_BUNDLE_NAME}.zip; \
  rm /opt/${WSO2_FOLDER_NAME}.listfiles;

ENV JAVA_HOME /opt/java

# Working Directory in Container
WORKDIR /opt/${WSO2_FOLDER_NAME}/bin/

# Start WSO2-AM
CMD sh ./wso2server.sh -DportOffset=${WSO2_PORT_OFFSET}