FROM google/cloud-sdk:alpine

RUN apk add --update --no-cache curl tar \
	&& rm -rf /var/lib/apt/lists/* \
    /var/cache/apk/* \
    /usr/share/man \
    /tmp/*

ARG GOLANG_VERSION=1.9.7
ARG SHA=88573008f4f6233b81f81d8ccf92234b4f67238df0f0ab173d75a302a1f3d6ee
ARG BASE_URL=https://dl.google.com/go/go${GOLANG_VERSION}.linux-amd64.tar.gz

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
