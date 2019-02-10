A spring boot / spring cloud end to end example


|Component|Port|Docker Name|Source Code|
|---|---|---|---|
|discovery-server|8761|logicalenigma/discovery-server|https://github.com/dnachman/lesb-discovery-server|
|config-server|8888|Not implemented yet||
|gateway-backend|8080|logicalenigma/gateway-backend|https://github.com/dnachman/lesb-gateway-backend|
|gateway-frontend|8081|Not implemented yet||
|app-home|8001|Not implemented yet||
|service-hostinfo|8101|logicalenigma/service-hostinfo|https://github.com/dnachman/lesb-service-hostinfo|
|service-comments|8102|Coming soon|https://github.com/dnachman/lesb-service-comments|


Notes:
- https://github.com/spring-cloud/spring-cloud-netflix/issues/1820


Building for Raspberry Pi:
docker build -f ./Dockerfile.rpi -t logicalenigma/discovery-server:latest-rpi .
docker push logicalenigma/discovery-server:latest-rpi
