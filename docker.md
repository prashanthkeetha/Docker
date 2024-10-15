* Docker: Docker is a container based application used to run microservices. 
container: container is an isolated area created by container engine have lean OS and application runs inside the container.
By using docker we can build and package the application.
* For nodejs and dotnet we to place the code inside the server. 
each container get
1.CPU 
2.RAM
3.IP ADDRESS
* When we install docker we get docker engine 
1. docker Engine have:
a. Client and server.
After installing docker we get the client running if we want to run the server, we need the command <sudo usermod -aG docker <username> >
-a is a active user G is a Group of docker
--- (By using 1 IMAGE we can RUN Multiple Containers)
After entering the command we need the exit form the VM and login back.
* Tu see weather the docker engine is working we need enter command <docker info> . 
* To run the container we use images.
----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
* To see the list of images command <docker image ls > to see all use <docke image ls -a>
* In docker for the image there will be <Repository (name of image)> and tag <version> 
* to pull th image from docker registry we use <docker image pull <imaganame:tag> >
* we build the images to run containers.
* To push the image into the docker registry <docker image push <iamgename:tag> >,
* to build the image <docker build -t <nameoftheimage:withtag> .> example: docker build -t image:1.1 .
* To see the running images in the docker we use <docker image ls>.
* To run the container with port number we use the command <docker container run -it -p <portno> name of the image:tag /bin/bash >,<docker container -d -P image name:tag>
-it is a interactive mode where we go into the container as a root user.
-d uses for distractive mode where we can see only the container id.
* Now, Create the container by using images
# docker run -itd --name cont1 -p 8081:80 httpd
* to go inside the container use <docker container exec -it (containerid) /bin/bash>
* To remove the images from <docker image rm (image-name or id)> (or) To remove multiple images at once <docker image rm -f $(docker image ls -q )>
* To remove the containers command <docker container rm (container-id)> (or) 
* To remove multiple containers at <docker container rm -f $(docker container ls -a -q)> (or) docker rm $(docker ps -a -q)
* To start the container <docker container start container name (or) container id>
* To stop the container <docker container stop container name (or) container id>
* To delete the container first you need to stop <docker container delete container name (or) container id>
# IMAGE push to private Registry:
----------------------------------
-> To tag the image with the private registary.
# CMD: docker image tag <nameofthe image> <accountname/tag>
Docker hub: Naming convention is <account-name>/<image-name>:<tag>
{ account name => shaikkhajaibrahim
image name: scr
tag: 1.0 }
Now let me tag the already built image scr:1.0 to shaikkhajaibrahim/scr:1.0
# docker image tag scr:1.0 shaikkhajaibrahim/scr:1.0
# Docker Commit
---------------
From docker commit we can create image from running container
# CMD: docker commit <imagename or id>
To give name to the image we use
# CMD: docker image tag <imageid> assigntherequiredname.
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------ 
* Every container has its own 
1. Network ip address.
2. CPU
3. RAM
4. Filesystem share
* To see the utilization of RAM we use <docker stats>, By using the command we can see 
<CONTAINER ID   NAME      CPU %     MEM USAGE / LIMIT   MEM %     NET I/O   BLOCK I/O   PIDS>
* To go inside the container we can use the command <docker container run -it image:tag /bin/bash (or) /bin/sh> .

# INSTRUCTIONS
---------------------------------------------------------------------------------------------------------------
* Docker filesystem  is ( var/lib/docker ) where the docker files are stored . 
* Namespace is a isolated area, which have storage and we can mount the network    interface in the namespace. 
* By using Cgroups kernal can control the storage impose limits on the RAM.
* If we want to run the web application we need the middleware <webservers (apache,Tomcat, springboot have jetty server to run the web application and jboos) > .
* To write the dockerfile we need this instructions.
1. FROM : By using this we take the base image with required dependencies.
2. RUN: By using run we can install/configure application
4. EXPOSE: It is used to expose the port.
5. CMD:To start the application when container is created  
6. COPY: copy data only from the local machine
7. ADD: By using this instruction we can copy the data from local and web. 
8. ARG: where we pass the arguments where pass the values and tags if we use.<ARG Branch = required branch name on which the dependencies are there> and we can pass many things
           -> It is used for the flexibilty of the Docker image. 
9. ENV: it is used to pass environment variables dynamicall in command we can use it in the container also <docker container run -e (statement) -it imagename:tag /rootdirectory >
10. WORKDIR: it is folder or path we used to store the data.
11. Label: instruction is used to add metadata.
12. USER: This is used to set the default user in the container when the container is started/created
13. EMTRYPOINT: The entrypoint is used to start the container like the CMD the commands which we are passing are cannot be over ridden.
------------------------------------------------------------------------------------------------------------------
* Some appliactions run on the server by starting server we can start the container <systemctl start (servername)>
* Docker image is aa collection of image layers.
* Docker layers are created by adding the instruction to the (dockerfile).
* Docker image layer are stored in docker filesystem (or) root /var/lib/docker.
* docker image have READ only LAYER but, After creating the container the docker container have read write layer.    
* To inspect the image <docker image inspect> 
* By using <docker logs (container id)> we can see the container information.
* Docker needs a special filesystem which can show the layers mounted on each other as normal file system. To make it possible docker has special file systems such
    as overlay and union file system.
----------------------------------------------------------------------------------------------------------------------
# docker have multistaged dockerfile.
* In the first we is used to build the package and in the second or last stage contain we used to build the image.
* Afterbuilding the package in the first stage by USING <COPY (we can capy the package from first to second stage)> 
# COPY --from = name give to the firststage or name given topackage building stage and src and dest
----------------------------------------------------------------------------------------------------------------------

###
# Docker Volumes:

# Docker volumes are used to persist the data even after the container is deleted.
* docker container has a read write layer when ever we make changes in the image layer it stores the changing data in the container read write layer.
* Any changes we do inside the container it will not effect to the image layer it only makes chnages in the container.
* the life time of the chnages we make in the container is as long as the container is works if the container is deleted the data in the container is lost.
* Docker volumes are three types 
# Bind mount
command <docker container run -d --mount "type=bind,source=/tmp/cont-temp,target=/tmp" --name (by using --name we can name the container) image name>
* By using docker bind mount we can mount the storage to existing folder in host.
* If we clean the data we will lose it.
# volumes
* Docker volume is created in the cloud by using driver(-d) 
* Docker volume is created by <docker volume create (volume name)>
* to see the path that docker volume create <docker volume inspect(volume name)>
# docker container run --name mysql-primary -d -P --mount "source=mysql-employee-vol,target=/var/lib/mysql" -e "MYSQL_ROOT_PASSWORD=rootroot" -e "MYSQL_USER=qtdevops" -e "MYSQL_PASSWORD=qtdevops" -e "MYSQL_DATABASE=employee" mysql
COMMAND2
# docker container run -d --mount "source=<nameofthevolume>,target=<nameofthetarget>" 
# tmpfs 
     This gets mounted to the RAM/memory into container. This is useful only for applications which require preset data to be present in memory.

* the command <exec> which means run the command in the running container.
--------------------------------------------------------------------------
* How to copy workdir data from container workdir to localdir
# CMD: docker cp <container id> source and destination

# Networking
* There are two diffrent types pf Networks are ther in docker
1. Bridge Network:
   Bridge Network: This is the default network type. Containers on the same bridge network can communicate with each other using IP addresses. Docker assigns IP addresses to containers automatically or allows you to specify them.
2. Host Network:
   Host Network: Using the host network allows a container to share the host's network namespace. This means the container uses the host's network directly, rather than getting its own network stack. It can improve network performance but reduces isolation.
3. Overlay Network: 
   Overlay networks: facilitate communication between containers running on different Docker daemons. They are used in Docker Swarm mode primarily 
   and provide transparent communication across multiple Docker hosts.
   # docker network create <network_name>
   # docker network ls
   # docker network inspect <network_name>
   # docker network connect <network_name> <container_name>
   # docker network disconnect <network_name> <container_name>
   # docker network rm <network_name>

* In the vm we have 2 networks 1. eth0 and 2.lo(loopback adaptar network(localhost,127.0.0.7)by using this we can connect to the browser)
* After installing docker we will get one more network called (docker0)
* Created a linux vm and verified network interfaces. we had two interfaces
  loopback (lo) => 127.0.0.1/localhost
  eth0
* We had installed docker on the linux machine and one more interface got created
  docker0
* Now we have create a docker container and verified the network interfaces we got two interfaces
  loopback (lo)
  eth0
  DOCKER COMPOSE:
  --------------
              Docker compose is used to run multiple containers at once instead of using each command.

    # CMD:
          * docker-compose up -d
          * dokcer-compose ls or ps
          * docker-compose ls --all
          * to down the docker compose use <docker-compose down>
          * docker compose watch
          * docker compose stop
          * docker compose down 
      # Services:
          
          The example application is composed of the following parts:

2 services, backed by Docker images: webapp and database
1 secret (HTTPS certificate), injected into the frontend
1 configuration (HTTP), injected into the frontend
1 persistent volume, attached to the backend
2 networks

services:
  frontend:
    image: example/webapp
    ports:
      - "443:8043"
    networks:
      - front-tier
      - back-tier
    configs:
      - httpd-config
    secrets:
      - server-certificate

  backend:
    image: example/database
    volumes:
      - db-data:/etc/data
    networks:
      - back-tier

volumes:
  db-data:
    driver: flocker
    driver_opts:
      size: "10GiB"

configs:
  httpd-config:
    external: true

secrets:
  server-certificate:
    external: true

networks:
  # The presence of these objects is sufficient to define them
  front-tier: {}
  back-tier: {}
###
Questions:
----------
1. What is containerd
------------------
Ans. It is specification how container should be. Here containers run by using containerd and it calls runc to run containers by using images.
2.What is OCI runc
--------------
Ans. It is image specification where we can run the containers.
3.What is shim
4.How do we take base image
5.What is entrypoint
6.How to start service.

Basic Dockerfile singel stage
------------------------------

FROM image name
RUN apt-get update &&\
    apt-get install -y wget curl
# Directory that given by the developer or in the host directory
WORKDIR ./prashanth
# copy the data from the workdir to the destination
COPY ./prashanth /prashanth/file.txt

EXPOSE 8080
CMD ["catalina.sh","run"]

Multistage:

FROM maven:3.8.6-openjdk-11 as build
RUN git clone https://github.com/spring-projects/spring-petclinic.git && \
    cd spring-petclinic && \
    mvn package
# jar location /spring-petclinic/target/spring-petclinic-2.7.3.jar

FROM openjdk:11
LABEL project="petclinic"
LABEL author="devops team"
EXPOSE 8080
COPY --from=build /spring-petclinic/target/spring-petclinic-2.7.3.jar /spring-petclinic-2.7.3.jar
CMD ["java", "-jar", "/spring-petclinic-2.7.3.jar"]



WORKED
-------
FROM ubuntu:latest
RUN apt-get update && apt-get install openjdk-17-jdk -y
RUN apt-get install wget curl -y
RUN mkdir path
COPY */path tmp
EXPOSE 8080
CMD ["/bin/bash"]

FROM maven:3-openjdk-8 AS builder
RUN git clone https://github.com/wakaleo/game-of-life.git && cd game-of-life && mvn package


# application image
FROM tomcat:9
LABEL author="khaja"
COPY --from=builder /game-of-life/gameoflife-web/target/gameoflife.war /usr/local/tomcat/webapps/gameoflife.war
EXPOSE 8080

FROM MySQL:8.0
RUN mkdir ./source
WORKDIR ./source
COPY ./source /source
ARG user=prashanth
ARG name=database 
ARG password=dbpassword
ARG rootpassword=rootdbpw
ENV MYSQL_DATABASE=$name
ENV MYSQL_USER=$user
ENV MYSQL_rootpassword=$rootpassword


# MULTISTAGE:
-------------
FROM ubuntu:22.04 as unzip
RUN mkdir /Nop
RUN apt update && \
    apt install wget unzip -y && \
    cd /Nop && \
    wget "https://github.com/nopSolutions/nopCommerce/releases/download/release-4.50.3/nopCommerce_4.50.3_NoSource_linux_x64.zip" &&\
    unzip /Nop/nopCommerce_4.50.3_NoSource_linux_x64.zip && \
    rm /Nop/nopCommerce_4.50.3_NoSource_linux_x64.zip


FROM mcr.microsoft.com/dotnet/aspnet:6.0
LABEL author="khaja"
COPY  --from=unzip /Nop /Nop
WORKDIR /Nop
EXPOSE 80
CMD ["dotnet","/Nop/Nop.Web.dll"]

# docker-compose.yaml:
version: '3.9'

services:
  webserver:
    image: nginx:latest
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx/nginx.conf:/etc/nginx/nginx.conf:ro
      - ./nginx/certs:/etc/nginx/certs:ro
      - ./frontend/build:/usr/share/nginx/html:ro
    depends_on:
      - frontend
      - backend

  frontend:
    build:
      context: ./frontend
    volumes:
      - ./frontend:/usr/src/app
      - /usr/src/app/node_modules
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production

  backend:
    build:
      context: ./backend
    volumes:
      - ./backend:/usr/src/app
      - /usr/src/app/node_modules
    ports:
      - "4000:4000"
    environment:
      - NODE_ENV=production
      - DATABASE_URL=postgresql://db:5432/mydatabase

  db:
    image: postgres:latest
    volumes:
      - db-data:/var/lib/postgresql/data
    environment:
      - POSTGRES_USER=youruser
      - POSTGRES_PASSWORD=yourpassword
      - POSTGRES_DB=mydatabase
    ports:
      - "5432:5432"

  data-volume:
    image: busybox
    volumes:
      - db-data:/var/lib/postgresql/data
    command: ['sh', '-c', 'echo "Data volume container"']

volumes:
  db-data:
    driver: local

project-root/
│
├── nginx/
│   ├── nginx.conf
│   └── certs/
│       ├── yourdomain.crt
│       ├── yourdomain.key
│
├── frontend/
│   ├── Dockerfile
│   ├── package.json
│   ├── package-lock.json
│   └── src/
│       └── ... (your frontend source code)
│
├── backend/
│   ├── Dockerfile
│   ├── package.json
│   ├── package-lock.json
│   └── src/
│       └── ... (your backend source code)
│
├── docker-compose.yaml
└── README.md

# MULTISTAGE
FROM ubuntu:latest as progress
RUN mkdir prime
RUN apt-get update && \
    apt-get install -y wget curl
RUN cd prime

FROM image
COPY --from=progress /prime/prime
WORKDIR /prime
EXPOSE 8080
CMD ["/bin/bash"]