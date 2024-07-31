ARG IMAGE_TAG=latest
FROM maven:3.9.7-amazoncorretto-17-debian AS build

WORKDIR /app

COPY src ./src

COPY pom.xml . 

RUN mvn package

FROM gcr.io/distroless/java17-debian12:${IMAGE_TAG}

WORKDIR /app

COPY --from=build /app/target/spring-petclinic-3.3.0-SNAPSHOT.jar .

EXPOSE 8080

CMD ["spring-petclinic-3.3.0-SNAPSHOT.jar"]