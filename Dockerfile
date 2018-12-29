
FROM openjdk:8-jdk-alpine
VOLUME /tmp
ARG JAVA_OPTS
ENV JAVA_OPTS=$JAVA_OPTS
ADD target/discovery-server-0.0.1-SNAPSHOT.jar discovery-server.jar
EXPOSE 8761
#ENTRYPOINT exec java $JAVA_OPTS -jar discovery-server.jar
# For Spring-Boot project, use the entrypoint below to reduce Tomcat startup time.
ENTRYPOINT exec java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar discovery-server.jar
