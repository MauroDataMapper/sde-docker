FROM amazoncorretto:17.0.7-alpine
WORKDIR /home/app
COPY layers/classes /home/app/classes
COPY layers/admin-api-0.1-all.jar /home/app/admin-api-0.1-all.jar
EXPOSE 8082
ENTRYPOINT ["java", "-classpath", "/home/app/classes/:/home/app/admin-api-0.1-all.jar", "sde.management.apis.admin.Application"]
