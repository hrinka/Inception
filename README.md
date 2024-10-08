# <img width="100" alt="42logo" src="https://github.com/user-attachments/assets/7d4368b3-3881-40fe-9e71-9d18625a3c71">   Inception


![facebook_cover_photo_2](https://github.com/user-attachments/assets/87d3657e-5a41-4393-8e6a-0e175407725e)
This project from 42 school aims to broaden your knowledge of system administration by using Docker. IIn this tutorial You will virtualize several Docker images, creating them in your new personal virtual machine. In this read.me you will have an inception tutorial to know how the project works.


## What are Containers ?
Containers are an abstraction at the app layer that packages code and dependencies together. Multiple containers can run on the same machine and share the OS kernel with other containers, each running as isolated processes in user space. Containers take up less space than VMs (container images are typically tens of MBs in size), can handle more applications and require fewer VMs and Operating systems.

## What are Virtual Machines ?
Virtual machines (VMs) are an abstraction of physical hardware turning one server into many servers. The hypervisor allows multiple VMs to run on a single machine. Each VM includes a full copy of an operating system, the application, necessary binaries and libraries – taking up tens of GBs. VMs also slow to boot.

## Why Docker and What is the problem that is solving ?
so let’s imagine a scenario pre docker era we have tester and developer and the developer
has just the code and its works perfectly fine on there system but when the tester take the code the test it in his machine its just doesn’t work and the reason could be a lot of thing it it might be the tester need some dependencies need to be installed in order for the code to work properly or some environnement variables needed to be added but they don’t exist it the tester machine. that means we found the problem how can we solve it ?


<img width="500" alt="スクリーンショット 2024-10-08 14 17 30" src="https://github.com/user-attachments/assets/a29447b2-e865-43f4-8d33-ac51f9ce1e22">



## Virtual Machine vs Docker
|Virtual Machine	| Docker |
|---|---|
|Occupy a lot of memory space	| Occupy a lot less memory space |
|long time to boot up	| quick boot up (because it uses the running kernel that you using)|
|Difficult to scale up	| super easy to scale |
|low efficiency	| high efficiency|
|volumes storage cannot be shared across the VM’s	| volumes storage can be shared across the host and the containers|

## How Docker Engine works
<img width="680" alt="スクリーンショット 2024-10-08 14 59 46" src="https://github.com/user-attachments/assets/85f2c1bf-2f9a-4dd9-a2bc-5d19a00afaa5">
Here's how the Docker engine works:

1. You write a Dockerfile, which is a text file that contains the instructions for building a Docker image. A Docker image is a lightweight, stand-alone, executable package that includes everything needed to run a piece of software, including the application code, libraries, dependencies, and runtime.
2. You use the Docker client to build the Docker image by running the docker build command and specifying the path to the Dockerfile. The Docker daemon reads the instructions in the Dockerfile and builds the image.
3. Once the image is built, you can use the Docker client to run the image as a container by using the docker run command. The Docker daemon creates a container from the image and runs the application inside the container.
4. The Docker engine provides a secure and isolated environment for the application to run in, and it also manages resources such as CPU, memory, and storage for the container.
5. You can use the Docker client to view, stop, and manage the containers running on your system. You can also use the Docker client to push the Docker image to a registry, such as Docker Hub, so that it can be shared with others.

 ## Dockerfile and Docker-compose file
- A Dockerfile is a text file that contains the instructions for building a Docker image. It specifies the base image to use, the dependencies and software to install, and any other configurations or scripts that are needed to set up the environment for the application to run.

- A Docker Compose file is a YAML file that defines how multiple Docker containers should be set up and run. It allows you to define the services that make up your application, and then start and stop all of the containers with a single command.

Here are some key differences between a Dockerfile and a Docker Compose file:

1. Purpose: A Dockerfile is used to build a single Docker image, while a Docker Compose file is used to define and run multiple Docker containers as a single application.
2. Format: A Dockerfile is a plain text file with a specific format and syntax, while a Docker Compose file is written in YAML.
3. Scope: A Dockerfile is focused on building a single image, while a Docker Compose file is focused on defining and running multiple containers as a single application.
4. Commands: A Dockerfile uses specific commands, such as `FROM`, `RUN`, and `CMD`, to define the instructions for building the image. A Docker Compose file uses different commands, such as `services`, `volumes`, and `networks`, to define the containers and how they should be set up and run.

## Docker commands
- `docker build`: Used to build a Docker image from a Dockerfile.
- `docker run`: Used to run a Docker container based on a Docker image.
- `docker pull`: Used to pull a Docker image from a registry, such as Docker Hub.
- `docker push`: Used to push a Docker image to a registry.
- `docker ps`: Used to list the running Docker containers on a system.
- `docker stop`: Used to stop a running Docker container.
- `docker rm`: Used to remove a Docker container.
- `docker rmi`: Used to remove a Docker image.
- `docker exec`: Used to execute a command in a running Docker container.
- `docker logs`: Used to view the logs for a Docker container.

## DOCKER COMPOSE
- Docker Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to configure your application's services. Then, using a single command, you can create and start all the services from your configuration.

- Using Docker Compose can simplify the process of managing multi-container applications by allowing you to define all of your services in a single place and easily start and stop them. It also makes it easy to scale your application by allowing you to increase or decrease the number of replicas of a service.

## docker-compose commands
- `up`: Create and start containers
- `down`: Stop and remove containers, networks, images, and volumes
- `start`: Start existing containers
- `stop`: Stop running containers
- `restart`: Restart running containers
- `build`: Build images
- `ps`: List containers
- `logs`: View output from containers
- `exec`: Run a command in a running container
- `pull`: Pull images from a registry
- `push`: Push images to a registry

## What are DOCKER NETWORKS
In Docker, a network is a virtual software defined network that connects Docker containers. It allows containers to communicate with each other and the outside world, and it provides an additional layer of abstraction over the underlying network infrastructure.

There are several types of networks that you can create in Docker, including:

- Bridge: A bridge network is the default network type when you install Docker. It allows containers to communicate with each other and the host machine, but provides no access to the outside world.
- Host: A host network uses the host machine's network stack and provides no isolation between the host and the container.
- Overlay: An overlay network allows containers running on different Docker hosts to communicate with each other.
- Macvlan: A Macvlan network allows a container to have its own IP address on the same subnet as the host machine.
You can create and manage networks using the docker network command. For example, to create a new bridge network, you can use the following command:

`docker network create my-network`

## What are DOCKER VOLUMES
In Docker, a volume is a persistent storage location that is used to store data from a container. Volumes are used to persist data from a container even after the container is deleted, and they can be shared between containers.

There are two types of volumes in Docker:

- Bind mount: A bind mount is a file or directory on the host machine that is mounted into a container. Any changes made to the bind mount are reflected on the host machine and in any other containers that mount the same file or directory.
- Named volume: A named volume is a managed volume that is created and managed by Docker. It is stored in a specific location on the host machine, and it is not tied to a specific file or directory on the host. Named volumes are useful for storing data that needs to be shared between containers, as they can be easily attached and detached from containers.
You can create and manage volumes using the `docker volume` command. For example, to create a new named volume, you can use the following command:

`docker volume create my-volume`
To mount a volume into a container, you can use the -v flag when starting the container. For example:

`docker run -v my-volume:/var/lib/mysql mysql`

This command will start a container running the `mysql` image and mount the `my-volume` volume at /var/lib/mysql in the container. Any data written to this location in the container will be persisted in the volume, even if the container is deleted.

You can also use Docker Compose to create and manage volumes. In a Compose file, you can define a volume and attach it to a service. For example:

```
version: '3'
services:
  db:
    image: mysql
    volumes:
      - db-data:/var/lib/mysql
volumes:
  db-data:
```
This Compose file defines a `db-data` volume and attaches it to the `db` service at `/var/lib/mysql`. Any data written to this location in the container will be persisted in the volume.

# Mandatory Part
## MARIADB
## WORDPRESS
## NGINX
