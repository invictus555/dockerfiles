FROM golang:1.16.0 AS development
WORKDIR $GOPATH/src/
RUN go env -w GOPROXY=https://goproxy.cn,direct
RUN git clone https://github.com/invictus555/greeting-server.git

# 切换源码目录下执行编译流程
WORKDIR greeting-server
RUN go build -o greeting-server main.go serverimpl.go

FROM ubuntu:latest AS production
WORKDIR /usr/local/bin
COPY --from=development /go/src/greeting-server/greeting-server .
EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/greeting-server"]