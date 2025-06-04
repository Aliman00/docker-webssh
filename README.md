# docker-webssh

A [WebSSH](https://pypi.org/project/webssh/) container designed for convenient deployment, including an OpenShift template for streamlined setup.

This project provides a simple way to run the [WebSSH](https://pypi.org/project/webssh/) Python package in a containerized environment. While there are many web-based SSH terminals (such as Wetty, WebSSH2, and others, often built on [xterm.js](https://xtermjs.org/) and Node.js), this solution is based on Python and Alpine Linux for a lightweight footprint.

> **Note:** The container uses a low keepAliveTimeout, so session persistence may not be ideal for long-running workshops.

---

## Usage

### Build from Dockerfile

You can build the Docker image locally using the provided Dockerfile. This setup uses Python 3.7.4 on Alpine Linux, installs the required packages and WebSSH, launches a WebSSH instance, and exposes port 8888.

```sh
git clone https://github.com/Aliman00/docker-webssh
cd docker-webssh
docker build -t aliman00/docker-webssh .
```

Then run the container:

```sh
docker run -p 8888:8888 aliman00/docker-webssh:latest
```

Navigate to [http://localhost:8888](http://localhost:8888) in your browser to access WebSSH.

### Pull from Docker Hub

If you prefer not to build the image yourself, you can pull it from Docker Hub:

```sh
docker run -p 8888:8888 aliman00/docker-webssh:latest
```

### Deploy to OpenShift

For OpenShift users, an OpenShift template is provided for rapid deployment:

```sh
oc create -f https://raw.githubusercontent.com/Aliman00/docker-webssh/master/openshift-template.yml
oc new-app webssh
```

This will create:
- A DeploymentConfig that pulls the container image from Docker Hub (the version can be set via a template parameter)
- A Service (configurable via parameter)
- A Route to expose the service

> **Security Advisory:** Always secure your OpenShift route with TLS/SSL. Exposing SSH over an insecure web browser is not recommended. Ensure you understand how your cluster handles SSL termination and apply appropriate security measures.

---

## License

This project is licensed under the MIT License.

---

## Credits

Inspired by [kenmoini/docker-webssh](https://github.com/kenmoini/docker-webssh) and the [WebSSH](https://pypi.org/project/webssh/) Python package.