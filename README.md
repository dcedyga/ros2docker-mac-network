# ros2docker-mac-network
Ros2 Docker Mac Network

The objective of this small project is to provide a guideline to create a ros2 network that connects your Mac(osx) with your docker containers. The Mac docker desktop distribution has its own peculiarities and is different to the linux distribution as it doesn't allow to share the network between the host and the docker containers.

In order to create a ros2 network we have to do the following:

- Install docker-mac-network from [wojas/docker-mac-network](https://github.com/wojas/docker-mac-network) or the [/docker-mac-network](docker-mac-network) folder from this repo. This will create a docker network called "docker-mac-network" with openvpn and the relevant ovpn configuration that can be used with [Tunnelblick](https://tunnelblick.net/downloads.html) to connect your mac to your docker containers that use the "docker-mac-network"
- 
