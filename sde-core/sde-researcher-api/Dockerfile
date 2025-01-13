FROM amazoncorretto:17.0.7-alpine
WORKDIR /home/app
COPY layers/classes /home/app/classes
COPY layers/researcher-api-0.1-all.jar /home/app/researcher-api-0.1-all.jar
EXPOSE 8083
ENTRYPOINT ["java", "-classpath", "/home/app/classes/:/home/app/researcher-api-0.1-all.jar", "sde.management.apis.researcher.Application"]
