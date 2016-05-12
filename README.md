# docker-tomcat
Docker image to deploy a Tomcat server.

## Requirements

* Docker (1.6.0 minimum)

## Description

This Docker image is based on:

* Alpine 3.1
* Oracle JRE 1.8.45
* Tomcat 8.0.33

### Volume

Exports a volume on ```/usr/local/tomcat```. You can mount the volume on run to a local directory containing your configuration files or where your Web apps are stored.

### Ports

One port is exposed:

* 8080: HTTP access

## Usage

To deploy a Tomcat server run the following commands:

```
docker build -t jplu/tomcat .
docker run -d -p 8080:8080 -v /var/data/tomcat/:/usr/local/tomcat/webapps --name tomcat jplu/tomcat
```

Remember to update the command line in order to change ```/usr/local/tomcat/webapps``` to the directory you want on your host. If you do not want to share your local storage you can copy your ```.war``` file into the container with the command:

```docker cp app.war tomcar:/usr/local/tomcat/webapps/app.war```

## Documentation

It is possible to change the Tomcat version by updating the ```TOMCAT_MAJOR_VERSION``` and ```TOMCAT_MINOR_VERSION``` environment variables with the wanted version. It is also possible to increase the amount of memory dedicated to Tomcat by updating the ```MAX_HEAP_SIZE_MB``` environment variable.

In order to have admin access to Tomcat, update the file ```config/tomcat-users.xml``` with the proper credentials.
