# Deploying-to-cloud


🪜 Steps to deploy the Self-study platform to the cloud 

👩‍💻 Using a simple video streaming application since the project is not finished

📝 A clear explanation is given on the website


## Go to the website

[For Step by step deployment with code blocks - Click here](https://its-ammu.github.io/Deploying-to-cloud/)

## Summary

- The app is done and run in our localhost port 8080
- If it is successful then its packaged in a container using Docker
- The container is then pushed to GCP's Container registry
- Terraform is used to create OS image, VM instance and a firewall rule
- Once it is deployed the container is pulled into the VM and is run inside it
- At the end of the session infrastructure is destroyed 
