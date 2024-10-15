FROM golang:alpine
COPY httpenv.go /go
RUN go build httpenv.go

FROM alpine
RUN apk add --no-cache bash curl
RUN addgroup -g 1000 httpenv \
    && adduser -u 1000 -G httpenv -D httpenv
RUN touch dm1 dm2 dm3 dm4
COPY --from=0 --chown=httpenv:httpenv /go/httpenv /httpenv
EXPOSE 8888
# we're not changing user in this example, but you could:
# USER httpenv
CMD ["/httpenv"]
