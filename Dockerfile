FROM google/cloud-sdk:alpine

RUN apk add --update --no-cache curl tar \
	&& rm -rf /var/lib/apt/lists/* \
    /var/cache/apk/* \
    /usr/share/man \
    /tmp/*

ARG GOLANG_VERSION=1.14.1
ARG SHA=2f49eb17ce8b48c680cdb166ffd7389702c0dec6effa090c324804a5cac8a7f8
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
