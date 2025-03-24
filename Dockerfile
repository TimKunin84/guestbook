FROM golang:1.18 AS builder

WORKDIR /app

COPY main.go .

RUN go mod init guestbook
RUN go mod tidy

RUN go build -o main main.go

FROM ubuntu:18.04

# Copy the Go binary from the builder stage
COPY --from=builder /app/main /app/guestbook

# Copy static files
COPY public/index.html /app/public/index.html
COPY public/script.js /app/public/script.js
COPY public/style.css /app/public/style.css
COPY public/jquery.min.js /app/public/jquery.min.js

WORKDIR /app

CMD ["./guestbook"]

# Expose the app port
EXPOSE 3000

