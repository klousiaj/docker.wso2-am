## Supported Tags and Dockerfile Links
- latest, 1.10.0 [Dockerfile](https://github.com/klousiaj/docker.wso2-am/blob/master/Dockerfile)
- 1.9.1 [Dockerfile](https://github.com/klousiaj/docker.wso2-am/blob/1.9.1/Dockerfile)

## WSO2 API Manager
This image includes an instance of the WSO2 API manager and is built on the [klousiaj/oracle-java](https://hub.docker.com/r/klousiaj/oracle-java/) image. 

## What ports are exposed?
- 7711 - Thrift SSL port for secure transport, where the client is authenticated to DAS
- 8243 - NIO/PT transport port
- 8280 - NIO/PT transport port
- 9443 - HTTPS servlet transport
- 9763 - HTTP servlet transport
- 10397 - Thrift client and server ports

## Usage
This is intended to be used along with the [klousiaj/wso2-das:latest](https://hub.docker.com/r/klousiaj/wso2-das/) and [klousiaj/wso2am-mysql:latest](https://hub.docker.com/r/klousiaj/wso2am-mysql/) which have been created as a demonstrable architecture.

## Docker Compose
A docker-compose file is TBD.