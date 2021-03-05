# Builder image
FROM golang:1.16 as builder

# Set workspace
WORKDIR /src/jainishshah17/tugger/

# Copy source
COPY ./ /src/jainishshah17/tugger/

# Build microservices
RUN cd cmd/tugger && \
	CGO_ENABLED=0 GOOS=linux go build -a -tags netgo -ldflags '-w' -o /go/bin/tugger

# Runnable image
FROM gcr.io/distroless/static

# Copy microservice executable from builder image
COPY --from=builder /go/bin/tugger /

# Set Entrypoint
CMD ["/tugger"]
