# Deploying-to-cloud

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Fits-ammu%2FDeploying-to-cloud&count_bg=%233176E1&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)
![node-current](https://img.shields.io/node/v/express)
![GitHub last commit](https://img.shields.io/github/last-commit/its-ammu/Deploying-to-cloud?color=red)
https://img.shields.io/badge/Cloud%20provider-GCP-yellow

🪜 Steps to deploy the Self study platform to the cloud 

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
