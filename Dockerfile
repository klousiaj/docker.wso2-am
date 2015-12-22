##
# borrowed liberally from chilcano/wso2am
##

FROM centos:7
MAINTAINER J.P. Klousia <klousiaj>

# install curl so we can
RUN yum install -y curl; yum install -y wget; yum install -y unzip; yum upgrade -y; yum update -y;  yum clean all

# get Oracle java rather than the OpenJDK version
ENV JDK_VERSION 7u79
ENV JDK_BUILD_VERSION b15
RUN curl -LO "http://download.oracle.com/otn-pub/java/jdk/$JDK_VERSION-$JDK_BUILD_VERSION/jdk-$JDK_VERSION-linux-x64.rpm" -H 'Cookie: oraclelicense=accept-securebackup-cookie' && rpm -i jdk-$JDK_VERSION-linux-x64.rpm; rm -f jdk-$JDK_VERSION-linux-x64.rpm; yum clean all
ENV JAVA_HOME /usr/java/default

# create a WSO2 user to run the app as.
RUN useradd -ms /bin/bash wso2
USER wso2

ENV WSO2_BUNDLE_NAME = wso2am-1.9.1
ENV WSO2_FOLDER_NAME = wso2am

# expose the necessary ports to run the API Manager
EXPOSE 9443 9763 8280 8243 7711 10397

# move the file onto the container so it can be unzipped
RUN wget -q -P /opt https://s3-us-west-2.amazonaws.com/wso2-stratos/${WSO2_BUNDLE_NAME}.zip

# unzip the file and move it into place.
RUN unzip /opt/${WSO2_BUNDLE_NAME}.zip -d /opt/ > /opt/${WSO2_FOLDER_NAME}.listfiles; mv /opt/${WSO2_BUNDLE_NAME} /opt/${WSO2_FOLDER_NAME}; rm /opt/${WSO2_BUNDLE_NAME}.zip

# going to need to do a bit of local configuration
# TBD

# remove curl/unzip/wget since we don't need them.
RUN yum remove curl; yum remove wget; yum remove unzip; yum clean all

# Working Directory in Container
WORKDIR /opt/${WSO2_FOLDER_NAME}/bin/

# Start WSO2-AM
CMD sh ./wso2server.sh