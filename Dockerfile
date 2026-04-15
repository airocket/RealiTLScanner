FROM golang:1.22-alpine AS build
WORKDIR /src
COPY . .
RUN go build -o RealiTLScanner .

FROM alpine:latest
RUN apk add --no-cache ca-certificates
WORKDIR /app
RUN cd /app && wget https://github.com/Loyalsoldier/geoip/releases/latest/download/Country.mmdb
COPY --from=build /src/RealiTLScanner .
ENTRYPOINT ["./RealiTLScanner"]
