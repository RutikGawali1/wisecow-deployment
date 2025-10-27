# Cow Wisdom Web Server

## Prerequisites

* Install required packages: `fortune-mod` and `cowsay`
  Ensure the system has the necessary dependencies to run the Wisecow application.

## How to Use

* Run the application using the startup script: `./wisecow.sh`
* Open your browser and point it to the server port (default: 4499)

## What to Expect

* The Wisecow application should display humorous fortunes using cowsay.

## Problem Statement

* Deploy the Wisecow application as a Kubernetes application.

## Requirements

* Create a **Dockerfile** to build the Wisecow application image.
* Create **Kubernetes manifests** to deploy the application in a Kubernetes environment.
* Expose the Wisecow application as a Kubernetes service for accessibility.
* Implement a **GitHub Actions workflow** to automatically build a new Docker image whenever changes are pushed to the repository.
* **[Challenge Goal]**: Enable secure TLS communication for the Wisecow application.

## Expected Artifacts

* A GitHub repository containing:

  * The Wisecow application source code.
  * Dockerfile for creating the application image.
  * Kubernetes manifests for deployment and service exposure.
  * GitHub Actions workflow for CI/CD automation.
* The GitHub repository should be kept private, with access granted to authorized reviewers.
