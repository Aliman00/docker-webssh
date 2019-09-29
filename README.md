# docker-webssh

A [WebSSH](https://pypi.org/project/webssh/) container with OpenShift template for deployment.

There are plenty of different Web-based terminals out there, Wetty, WebSSH, WebSSH2, etc.  Most are just built on [xterm](https://xtermjs.org/) and run on some sort of Node server like express.js.

This particular container is built on the Python package [WebSSH](https://pypi.org/project/webssh/).  Not heavily used as keepAliveTimeout is low and does not persist well enough for workshops.


## Usage

### Build from Dockerfile

Basically it's a very simple **Dockerfile**, using Python 3.7.4 on Alpine Linux, installs needed packages, WebSSH, starts a WebSSH instance, and exposes the port 8888.

```
# git clone https://github.com/kenmoini/docker-webssh
# cd docker-webssh
# docker build - < Dockerfile
```

Then ```docker run``` and the image checksum of whichever was built.

### Pull from Docker Hub

Just want to use a pre-built and public container image?  Sure, no problem...

```
# docker run -p 8888:8888 kenmoini/docker-webssh:latest
```

Navigate to localhost:8888 to access the container.

### Deploy to OpenShift

One of those fancy fucks with an OCP cluster?  Dope - use the template in this repository to quickly deploy this same cluster.

```
# oc create -f https://raw.githubusercontent.com/kenmoini/docker-webssh/master/openshift-template.yml
# oc new-app webssh
```

This will create...

- A Deployment Configuration that pulls in the container image from Docker Hub - version can be set with a parameter in the template
- A Service that can be set via parameter
- A Route to expose the Service

#### ***NOTE:*** I would advise securing that Route with whatever means you do.  SSH over an insecure web browser is...dumb.  I can't predict how your cluster terminates SSL though - cert-manager, certmonger, Let's Encrypt, edge load balancer termination, etc.
