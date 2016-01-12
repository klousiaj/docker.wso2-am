##
# borrowed liberally from chilcano/wso2am
##

FROM klousiaj/oracle-java:7.79
MAINTAINER J.P. Klousia <klousiaj>

# install curl so we can
RUN yum install -y curl wget unzip; yum upgrade -y; yum update -y;  yum clean all

# create a WSO2 user to run the app as.
RUN useradd -ms /bin/bash wso2

ENV WSO2_BUNDLE_NAME wso2am-1.10.0
ENV WSO2_FOLDER_NAME wso2am

# expose the necessary ports to run the API Manager
EXPOSE 9443 9763 8280 8243 7711 10397

# move the file onto the container so it can be unzipped
RUN wget -q -P /opt https://www.dropbox.com/s/82yc9brsfey69ep/wso2am-1.10.0.zip; \
  unzip /opt/$WSO2_BUNDLE_NAME.zip -d /opt/ > /opt/${WSO2_FOLDER_NAME}.listfiles; \
  mv /opt/${WSO2_BUNDLE_NAME} /opt/${WSO2_FOLDER_NAME}; \
  rm /opt/${WSO2_BUNDLE_NAME}.zip; \
  rm /opt/${WSO2_FOLDER_NAME}.listfiles; \
  chown -R wso2:wso2 /opt/${WSO2_FOLDER_NAME};

# remove curl/unzip/wget since we don't need them.
RUN yum remove curl wget unzip; yum clean all
  
USER wso2
COPY assets/repository/components/lib/mysql-connector-java-5.1.38-bin.jar /opt/${WSO2_FOLDER_NAME}/repository/components/lib/mysql-connector-java-5.1.38-bin.jar

ENV JAVA_HOME /usr/java/default

# Working Directory in Container
WORKDIR /opt/${WSO2_FOLDER_NAME}/bin/

# Start WSO2-AM
CMD sh ./wso2server.sh