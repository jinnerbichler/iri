FROM openjdk:jre-slim
WORKDIR /iri
COPY ./target/iri-1.4.0.jar iri.jar
COPY ./testnetdb testnetdb
COPY logback.xml /iri

EXPOSE 14265
EXPOSE 14777/udp
EXPOSE 15777

CMD ["/usr/bin/java", "-Xmx8g", "-Xms256m", "-jar", "iri.jar", "-p", "14265", "--testnet", "--remote"]
