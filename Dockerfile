FROM armv7/armhf-debian

#############################
# apt-get dependencies
RUN apt-get update; apt-get install -y git curl wget build-essential python2.7
RUN ln -s /usr/bin/python2.7 /usr/bin/python

#############################
# Go
ENV GO_VERSION 1.8rc2
ADD go$GO_VERSION.linux-armv6l.tar.gz /usr/local
RUN mkdir -p /go/bin /go/pkg /go/src
ENV GOPATH /go
RUN echo "export PATH=\"/usr/local/go/bin:/go/bin:$PATH\"" >> /root/.bashrc

#############################
# Cloud9 IDE
EXPOSE 8080

#############################
# Web apps may use these ports
EXPOSE 8081
EXPOSE 8082

# add in some nice Cloud9 default settings
COPY user.settings /root/.c9/
COPY .c9 /go/.c9

# install cloud9 last to make updates smaller
RUN git clone git://github.com/c9/core.git c9sdk
RUN cd c9sdk; ./scripts/install-sdk.sh; ln -s /c9sdk/bin/c9 /usr/bin/c9; ln -s /root/.c9/node/bin/node /usr/bin/node

# start cloud9 with no authentication by default
# if authentication is desired, set the value of -a, i.e. -a user:pass at docker run
ENTRYPOINT ["/root/.c9/node/bin/node", "c9sdk/server.js", "-w", "/go", "--listen", "0.0.0.0", "-p", "8080"]
CMD ["-a", ":"]
