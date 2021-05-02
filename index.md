

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

To run the container locally 
```
docker run -p 3000:3000 self-study-platform
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
## Create infrastructure
> We are going to create the infrastructure using terraform - a infrastructure as code deployement manager

First make sure you are logged into your gcloud account using

```
gcloud auth login
```
Now to store the state file of the terraform we are going to create a bucket

```
gsutil mb -p $(PROJECT_ID) gs://$(PROJECT_ID)
```

Add the following code in terraform -> main.tf to store the state file in bucket
( I keep it int seperate files for easy understanding )

```tf
terraform {
    backend "gcs" {
        bucket = "self-study-platform"
        prefix = "/terraform-state"
    }
}
```

Initialize terraform using 
```
terraform init
```
For terraform to perform its operations it needs a service account. So create a service account using gcp console with the necessary permissions and download the key

Now specify the provider as google in gcp.tf 

```tf
provider "google" {
  credentials = file("sa-acnt-key.json")
  project     = var.gcp_project_id
  region      = "us-central1"
  zone        = "us-central1-c"
}
```
The variables used are declared in variables.tf file



