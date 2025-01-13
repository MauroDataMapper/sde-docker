echo Starting Flyway
./gradlew flywayMigrate
echo Finished Flyway

java -classpath /home/sde-admin-api/classes/:/home/sde-admin-api/admin-api-0.1-all.jar sde.management.apis.admin.Application &
java -classpath /home/sde-researcher-api/classes/:/home/sde-researcher-api/researcher-api-0.1-all.jar sde.management.apis.researcher.Application
