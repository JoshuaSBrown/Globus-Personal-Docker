# Globus-Personal-Docker

This repository contains a Dockerfile for building a Docker image that can be used to run a personal Globus Connect Server. The image is based on the [globus/globus-connect-server](https://hub.docker.com/r/globus/globus-connect-server) image, and adds a script that can be used to configure the server with a personal endpoint.

## Building the container

To build the container, run the following command:

```bash
docker build -t globus .
```

## Running the container

You need to start by running the container and doing the initial configuration. The following command will start the container and mount the necessary volumes:

```bash
DataPath=/home/ferroelectric/Globus-Personal-Docker-2/data
ConfigPath=/home/ferroelectric/Globus-Personal-Docker-2/config
docker run -e DataPath=$DataPath \
           -e ConfigPath=$ConfigPath \
           -v "$ConfigPath":/home/gridftp/globus_config \
           -v "$DataPath":/home/gridftp/data \
           -it globus
```

## Once the Setup is complete the endpoint can be started using the following command:

```bash
docker run -e DataPath="$DataPath"  \
           -e ConfigPath="$ConfigPath" \
           -e START_GLOBUS="true" \
           -v "$ConfigPath":/home/gridftp/globus_config \
           -v "$DataPath":/home/gridftp/data \
           -it globus
```

## Common Problems - Failed setup command

If the first `docker run` command fails with errors like:

```
cp: cannot create directory '/home/gridftp/globus_config/.globus': Permission denied
cp: cannot create directory '/home/gridftp/globus_config/.globusonline': Permission denied
cp: cannot create directory '/home/gridftp/globus_config/.globus': Permission denied
cp: cannot create directory '/home/gridftp/globus_config/.globusonline': Permission denied
```

the likely cause is a mismatch between the gridftp user inside the container
and the host user running Docker. You can check your host UID with:

```
id -u
```

If it is not 1000, this mismatch can prevent proper file access in the mounted
data volume. By default, Docker maps the container’s gridftp and root users to
UID 1000 on the host. This works only if the host user also has UID 1000.
Otherwise, you need to mount a compatible passwd file into the container.

Create the file using the helper script:

```
./generate_passwd.sh
```

Then, in the Running the container section, add the following flags to docker run: `-u $(id -u):0 -v ./passwd:/etc/passwd:ro`.
