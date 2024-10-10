FROM amazoncorretto:17.0.7-alpine
WORKDIR /home/app
COPY layers/libs /home/app/libs
COPY layers/classes /home/app/classes
COPY layers/resources /home/app/resources
COPY layers/application.jar /home/app/application.jar
EXPOSE 8083
ENTRYPOINT ["java", "-jar", "/home/app/application.jar"]
