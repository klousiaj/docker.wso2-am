##
# borrowed liberally from chilcano/wso2am
##

FROM centos:7
MAINTAINER J.P. Klousia <klousiaj>

# install curl so we can
RUN yum install -y curl wget unzip; yum upgrade -y; yum update -y;  yum clean all

# get Oracle java rather than the OpenJDK version
ENV JDK_VERSION 7u79
ENV JDK_BUILD_VERSION b15
RUN curl -LO "http://download.oracle.com/otn-pub/java/jdk/$JDK_VERSION-$JDK_BUILD_VERSION/jdk-$JDK_VERSION-linux-x64.rpm" -H 'Cookie: oraclelicense=accept-securebackup-cookie' && rpm -i jdk-$JDK_VERSION-linux-x64.rpm; rm -f jdk-$JDK_VERSION-linux-x64.rpm; yum clean all

# create a WSO2 user to run the app as.
RUN useradd -ms /bin/bash wso2

ENV WSO2_BUNDLE_NAME wso2am-1.9.1
ENV WSO2_FOLDER_NAME wso2am

# expose the necessary ports to run the API Manager
EXPOSE 9443 9763 8280 8243 7711 10397

# move the file onto the container so it can be unzipped
RUN wget -q -P /opt https://www.dropbox.com/s/nr8aqesio5ykn52/wso2am-1.9.1.zip?dl=0

# unzip the file and move it into place.
RUN unzip /opt/$WSO2_BUNDLE_NAME.zip -d /opt/ > /opt/${WSO2_FOLDER_NAME}.listfiles; mv /opt/${WSO2_BUNDLE_NAME} /opt/${WSO2_FOLDER_NAME}; rm /opt/${WSO2_BUNDLE_NAME}.zip; rm /opt/${WSO2_FOLDER_NAME}.listfiles
RUN chown -R wso2:wso2 /opt/${WSO2_FOLDER_NAME}

# going to need to do a bit of local configuration
# TBD

# remove curl/unzip/wget since we don't need them.
RUN yum remove curl wget unzip; yum clean all

USER wso2
ENV JAVA_HOME /usr/java/default

# Working Directory in Container
WORKDIR /opt/${WSO2_FOLDER_NAME}/bin/

# Start WSO2-AM
CMD sh ./wso2server.sh