## build stage
FROM maven:3.8.3-openjdk-17 as build

WORKDIR /app
COPY . .
RUN mvn install -DskipTests=true

## run stage
FROM alpine:3.19

RUN adduser -D demo-spring-boot

RUN apk add openjdk17

WORKDIR /run
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar /run

RUN chown -R demo-spring-boot:demo-spring-boot /run

USER demo-spring-boot

EXPOSE 8080

ENTRYPOINT java -jar /run/demo-0.0.1-SNAPSHOT.jar