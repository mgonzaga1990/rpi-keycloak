FROM mjayson/java8-rpi
MAINTAINER Mark Jayson Gonzaga <markjayson.gonzaga1990@gmail.com>

WORKDIR /data
RUN wget https://downloads.jboss.org/keycloak/10.0.2/keycloak-10.0.2.tar.gz \
      && tar xvfp keycloak-10.0.2.tar.gz \
      && rm keycloak-10.0.2.tar.gz

RUN mkdir -p /keycloak-10.0.2/modules/system/layers/keycloak/org/postgresql/main

COPY driver/postgresql-42.2.14.jre6.jar /data/keycloak-10.0.2/modules/system/layers/keycloak/org/postgresql/main/postgresql-42.2.14.jre6.jar
COPY driver/module.xml /data/keycloak-10.0.2/modules/system/layers/keycloak/org/postgresql/main/module.xml


COPY config/keycloak-add-user.json /data/keycloak-10.0.2/standalone/configuration/keycloak-add-user.json
COPY config/standalone.xml /data/keycloak-10.0.2/standalone/configuration/standalone.xml

CMD ["/data/keycloak-10.0.2/bin/standalone.sh", "-b", "0.0.0.0"]
EXPOSE 8080 9990
