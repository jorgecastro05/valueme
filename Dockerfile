# Alpine Linux with OpenJDK JRE
FROM openjdk:8-jre-alpine
# copy WAR into image
COPY build/libs/*.jar /valueme.jar
# run application with this command line 
CMD java -Dserver.port=$PORT $JAVA_OPTS -Dgrails.env=prod -jar /*.jar