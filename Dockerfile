FROM maven as maven
COPY ./settings.xml /usr/share/maven/conf/settings.xml
WORKDIR /app
COPY . /app
RUN mvn package

FROM tomcat:9.0.69-jdk17-temurin-jammy
WORKDIR /app
COPY --from=maven /app/target/CreatePDF.war pdf.war
RUN jar -xvf pdf.war && \
    mkdir /usr/local/tomcat/webapps/CreatePDF && \
    rm pdf.war && \
    cp -r . /usr/local/tomcat/webapps/CreatePDF && \
    cd /usr/local/tomcat/
