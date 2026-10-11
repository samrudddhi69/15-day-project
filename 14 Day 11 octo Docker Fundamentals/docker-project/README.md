# Docker Fundamentals Project

## Project Overview
This project demonstrates Docker fundamentals using Ubuntu on WSL.

## Topics Covered
- Docker installation and verification
- Running the Hello World container
- Running an Ubuntu container
- Building a custom Docker image
- Container management: start, stop, inspect, and execute commands
- Docker volumes and data persistence
- Docker networking using a custom bridge network
- Container name resolution using Docker DNS

## Project Structure
- `commands/` - Docker commands used during practice
- `documentation/` - Project report and Docker image/container details
- `hello-world/` - Dockerfile for the custom image
- `screenshots/` - Project screenshots

## Custom Docker Image
The custom image is named `my-hello-world` and uses the `hello-world` image as its base.

## Volume Practice
Created `my-project-volume` and verified that data persisted across temporary containers.

## Networking Practice
Created `my-project-network`, connected two Ubuntu containers, and verified container-name resolution.

## Learning Outcomes
Practised Docker images, containers, container lifecycle management, volumes, and networking.

## Environment
- Ubuntu on WSL
- Docker Engine
