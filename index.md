
Here are the Steps to deploy the Self study platform to cloud. We will be Using a simple video streaming application since the project is not finished

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

Now we have to push the image to the gcp's container registry

```
docker tag self-study-platform gcr.io/$(PROJECT_ID)/self-study-platform
docker push gcr.io/$(PROJECT_ID)/self-study-platform
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
The variables used are declared in variables.tf file. Add the following to variables.tf

```tf
variable "app_name" {
  type = string
}

variable "gcp_project_id" {
  type = string
}

variable "gcp_machine_type" {
  type = string
}
```

I will be using the default network for the VM instance since it is already available it should be specified as data dor resources to be newly created it should be specified as resource -> gcp.tf

```tf
data "google_compute_network" "default" {
  name = "default"
}
```

Next we will have to create a firewall rule to allow http access to port 8080 -> gcp.tf

```tf
resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = data.google_compute_network.default.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["allow-http"]
}
```

Then for the OS image and the vm instance -> gcp.tf

```tf
data "google_compute_image" "cos_image" {
  family  = "cos-81-lts"
  project = "cos-cloud"
}

resource "google_compute_instance" "instance" {
  name         = "${var.app_name}-vm"
  machine_type = var.gcp_machine_type
  zone         = "us-central1-a"

  tags = google_compute_firewall.allow_http.target_tags

  boot_disk {
    initialize_params {
      image = data.google_compute_image.cos_image.self_link
    }
  }

  network_interface {
    network = data.google_compute_network.default.name

    access_config {
      
    }
  }

  service_account {
    scopes = ["storage-ro"]
  }
}
```
Now the tf files are done we will have to create a tfvars file to define the variables -> values.tfvars

```tfvars
app_name="Student-self-study"
gcp_project_id="self-study-platform"
gcp_machine_type = "f1-micro"
```
The coding part is done. Lets see the execution plan

```
terraform plan \
    -var-file= "./values.tfvars" 
```

Now to deploy the infrastructure to gcp

```
terraform apply \
	-var-file= "./values.tfvars" 
```

## Running the container in VM instance

First SSH into the vm instance using the gcp console. Then to configure and authenticate container registry

```
docker-credential-gcr configure-docker
```
To pull the docker image from container registry
```
docker pull gcr.io/$(PROJECT_ID)/self-study-platform
```
To run the container
```
docker run -p 8080:8080 gcr.io/$(PROJECT_ID)/self-study-platform
```
Now if we go to the http://EXTERNAL-IP-OF-VM/8080 then we can see the video streaming service

Once done Stop and delete the containers using stop and rm commands

## Destroy Infrastructure

To destroy the infrastructure once everything is done

```
terraform destroy
```
<hr />

<center> That's it you are done! 🥳 </center>





