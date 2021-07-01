# ros2docker-mac-network
Ros2 Docker Mac Network

The objective of this small project is to provide a guideline to create a ros2 network that connects your Mac(osx) with your docker containers. The Mac docker desktop distribution has its own peculiarities and is different to the linux distribution as it doesn't allow to share the network between the host and the docker containers.

In order to create a ros2 network we need the following:

- Install docker-mac-network from [wojas/docker-mac-network](https://github.com/wojas/docker-mac-network) or the [/docker-mac-network](docker-mac-network) folder from this repo. This will allow us to create a docker network called "docker-mac-network" with openvpn and the relevant ovpn configuration that can be used with [Tunnelblick](https://tunnelblick.net/downloads.html) to connect your mac to your docker containers that use the "docker-mac-network"
- Use of [Fast-dds discovery server](https://fast-dds.docs.eprosima.com/en/latest/fastdds/ros2/discovery_server/ros2_discovery_server.html). For that we will need the following environment setup:
  - export RMW_IMPLEMENTATION=rmw_fastrtps_cpp
  - export ROS_DISCOVERY_SERVER="172.25.0.3:11811"
- Use of fast-dds super-client to enable the daemon to perform all the cli operations and allow it to discover all the nodes within the ros2 network. For that we will need the following environment setup:
  -   - export FASTRTPS_DEFAULT_PROFILES_FILE=$PATH_ROS_DOCKER_MAC_NET/ros2_profiles/super_client_configuration_file.xml

It has been tested with ros2 "galactic"
## guide

### First time:
- Run the [start.sh](start.sh). This will do the following.
  - Create docker network called docker-mac-network_default with subnet 172.25.0.0/16. This will allow us to set a static IP 172.25.0.3 to the fast-dds discovery server
  - Create the openVPN configuration in case that it doesn't exist. It will also comment "#comp-lzo no" line of the openvpn.conf as the ros2-galactic docker images don´t use comp-lzo. By doing this patching the OSX host will be able to ping the docker images
  - Create the fast-dds discovery server with ip 172.25.0.3
  - stop and start the ros2 daemon
- Double click on docker-for-mac.ovpn to load the configuration in Tunnelblick.
    <img src="images/tunnelblick-uploadconfig.png" alt="tunnelblick upload config" width="300"/>

- Connect to the docker-for-mac network

    <img src="images/tunnelblick-connect.png" alt="tunnelblick connect" width="150"/><img src="images/tunnelblick-connected.png" alt="tunnelblick connected" width="150"/>

- At this point you should be able to ping the discovery server
  ```bash
  ping 172.25.0.3
  ```
    <img src="images/ping.png" alt="ping fast-dds discovery server" width="350"/>



