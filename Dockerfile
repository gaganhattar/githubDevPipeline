FROM openjdk:11 AS BUILD_IMAGE
RUN apt update && apt install maven -y
COPY ./ githubDevPipeline
COPY ./ githubDevPipeline
RUN cd  &&  mvn install 

FROM tomcat:9-jre11
COPY ./ githubDevPipeline
LABEL "Project"=""
LABEL "Author"="Imran"
RUN rm -rf /usr/local/tomcat/webapps/*
COPY ./ githubDevPipeline
COPY --from=BUILD_IMAGE /target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
