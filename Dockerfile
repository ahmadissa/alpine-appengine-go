FROM google/cloud-sdk:alpine

RUN apk add --update --no-cache curl tar

ARG GOLANG_VERSION=1.8.7
ARG SHA=de32e8db3dc030e1448a6ca52d87a1e04ad31c6b212007616cfcc87beb0e4d60
ARG BASE_URL=https://storage.googleapis.com/golang/go${GOLANG_VERSION}.linux-amd64.tar.gz

RUN mkdir -p /usr/share/golang /usr/share/golang/gopath && \
	curl -fsSL -o /tmp/golang.tar.gz ${BASE_URL} && \
	echo "${SHA}  /tmp/golang.tar.gz" | sha256sum -c - &&\
	tar -xzf /tmp/golang.tar.gz -C /usr/share/golang --strip-components=1 && \
	rm -f /tmp/golang.tar.gz && \
	ln -s /usr/share/golang/bin/go /usr/bin/go

ENV GOROOT="/usr/share/golang" \
	GOPATH=/usr/share/golang/gopath/ \
	GOBIN=/usr/share/golang/gopath/bin

RUN gcloud components install app-engine-go && \
	go get -u google.golang.org/appengine
CMD sh
