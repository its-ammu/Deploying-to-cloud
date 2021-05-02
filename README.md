# Deploying-to-cloud

🪜 Steps to deploy the Self study platform to cloud 

👩‍💻 Using a simple video streaming application since the project is not finished

📝 Clear explaination is given in the website


## Go to the website

[For Step by step deployement with codeblocks - Click here](https://its-ammu.github.io/Deploying-to-cloud/)

## Summary

- The app is done and run in our localhost port 3000
- If it is succesfull it is then its packaged in a container using Docker
- The container is then pushed to gcp's Container registry
- Terraform is used to create OS image, Vm instance
- Once it is deployed the container is pulled into the vm and is run inside it
- In the end of the session infrastructure is destroyed 
