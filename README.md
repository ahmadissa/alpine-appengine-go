[![Docker Build Status](https://img.shields.io/docker/build/ahmadissa/alpine-appengine-go.svg)](https://hub.docker.com/r/ahmadissa/alpine-appengine-go/) [![Docker Pulls](https://img.shields.io/docker/pulls/ahmadissa/alpine-appengine-go.svg)](https://hub.docker.com/r/ahmadissa/alpine-appengine-go/)

# alpine-appengine-go
AppEngine Golang Docker Images built on Google CloudSDK Alpine Linux

# Supported tags and respective `Dockerfile` links

 * `latest` [(Dockerfile)](https://github.com/ahmadissa/alpine-appengine-go/blob/master/Dockerfile)

### Usage

Start using your devserver: `docker run --rm -it -h localhost -v $(pwd):/usr/src/app -w /usr/src/app -p 8080:8080 ahmadissa/alpine-appengine-go`

### Default command

```
dev_appserver.py app.yaml
```

### Deploy commands

Start a bash using `docker run --rm -it -h localhost -v ~/.m2:/root/.m2 -v $(pwd):/usr/src/app -v ~/.config/gcloud:/root/.config/gcloud -w /usr/src/app -p 8080:8080 ahmadissa/alpine-appengine-go`

We mount `.config/gcloud` to save the credentials.

Then use the following command:
```
gcloud auth login
#copy paste the url in your browser and then paste the token in your bash
gcloud config set project $PROJECT
gcloud config set app/promote_by_default false
gcloud app deploy --version $VERSION
```

### Golang version (latest)

```
docker run --rm ahmadissa/alpine-appengine-go go version
go version go1.14.1 linux/amd64
```
