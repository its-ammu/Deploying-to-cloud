# Deploying-to-cloud

🪜 Steps to deploy the Self study platform to cloud 

👩‍💻 Using a simple video streaming application since the project is not finished

## Installation

Server setup

```
npm init -y

npm install express nodemon
```
Modify the package.json "scripts" field to 

```
"start": "nodemon server"
```

Start the server 

```
npm start
```

## Dockerize the application 
> All the commands I have used are also in the Makefile

Create a Dockerfile and enter the given configuration ( The docker file is uploaded )

Create .dockerignore to ignore the dependancies

To build the docker image 

```
docker build ./ -t self-study-platform
```
The output will be

```
[+] Building 2.5s (10/10) FINISHED                                                                                                                          
 => [internal] load build definition from Dockerfile                                                                                                   0.0s
 => => transferring dockerfile: 36B                                                                                                                    0.0s
 => [internal] load .dockerignore                                                                                                                      0.0s
 => => transferring context: 34B                                                                                                                       0.0s
 => [internal] load metadata for docker.io/library/node:14-slim                                                                                        1.5s
 => [1/5] FROM docker.io/library/node:14-slim@sha256:027ca5b035e85229e96ebd4e60c26386126e6a208f238561759b3d68ac50cae9                                  0.0s
 => [internal] load build context                                                                                                                      0.0s
 => => transferring context: 4.13kB                                                                                                                    0.0s
 => CACHED [2/5] WORKDIR /usr/src/app                                                                                                                  0.0s
 => CACHED [3/5] COPY ./package*.json ./                                                                                                               0.0s
 => CACHED [4/5] RUN npm install                                                                                                                       0.0s
 => CACHED [5/5] COPY . .                                                                                                                              0.0s
 => exporting to image                                                                                                                                 0.0s
 => => exporting layers                                                                                                                                0.0s
 => => writing image sha256:60645587283d73e604a7d4f9ec1d86e90528926ca79b5e3e5edbf6b47c19a49b                                                           0.0s
 => => naming to docker.io/library/self-study-platform                                                                                                 0.0s

Use 'docker scan' to run Snyk tests against images to find vulnerabilities and learn how to fix them
```

To run the container locally 
```
docker run -p 3000:3000 self-study-platform
```
The output will be
```
> video@1.0.0 start /usr/src/app
> nodemon server

[nodemon] 2.0.7
[nodemon] to restart at any time, enter `rs`
[nodemon] watching path(s): *.*
[nodemon] watching extensions: js,mjs,json
[nodemon] starting `node server.js`
```
Now you can see the containers running using
```
docker ps

CONTAINER ID   IMAGE                 COMMAND                  CREATED          STATUS          PORTS                    NAMES
19f64b330726   self-study-platform   "docker-entrypoint.s…"   17 seconds ago   Up 15 seconds   0.0.0.0:3000->3000/tcp   strange_heyrovsky

```
To stop the container 
```
docker stop <Container id from docker-ps>
```
To remove stopped container
```
docker container rm <Container id>
```
## Push the container
