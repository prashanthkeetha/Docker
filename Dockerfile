FROM maven:3.8.6-openjdk-8 as build 
RUN  git clone https://github.com/prashanthkeetha/game-of-life.git 
WORKDIR game-of-life
RUN mvn install
WORKDIR gameoflife-web
RUN  mvn jetty:run 
EXPOSE 8080
CMD ["catalina.sh", "run"]