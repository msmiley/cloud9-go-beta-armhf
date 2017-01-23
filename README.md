# Cloud9 Docker Image for go Development using latest go unstable on ARM

Includes go 1.8rc2 running on Debian Jessie with working code completion and debugging. Builds on armhf devices (armv6, armv7).

## Run the container with defaults

```
docker run -d -p 8080:8080 msmiley/cloud9-go-beta-armhf
```

## Options

### PNAT the port and modify the mounted go directory

```
docker run -d -v ~/my_go_workspace:/go -p 8888:8080 msmiley/cloud9-go-beta-armhf
```


### Add basic authentication

```
docker run -d -v ~:/go -p 8080:8080 msmiley/cloud9-go-beta-armhf -a user:pass
```

Note: the password will be easily visible to anyone in the docker group, so no valuable passwords!
