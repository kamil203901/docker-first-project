FROM maven:3.5-jdk-8-alpine as build
WORKDIR /usr/src/my-first-docker-app
COPY . /usr/src/my-first-docker-app
ENV JAR_NAME="myDockerApp"
RUN mvn clean install -U
RUN chmod +x ./target/$JAR_NAME.jar

FROM openjdk:8-alpine
WORKDIR /app
COPY --from=build /usr/src/my-first-docker-app /app
ENV JAR_NAME="myDockerApp"
CMD ["sh", "-c", "java -jar ./target/${JAR_NAME}.jar"]

# budowanie: docker build -t my-first-docker-app .
# uruchamienie: docker run -it --rm --name docker-app my-first-docker-app
# todo: przeniesc zmienne do pliku .env