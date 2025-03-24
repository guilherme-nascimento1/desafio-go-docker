# Etapa de build
FROM golang:alpine AS builder

WORKDIR /app

COPY main.go .

RUN go mod init fullcycle && \
    CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o fullcycle main.go

# Imagem final mínima
FROM scratch

COPY --from=builder /app/fullcycle /fullcycle

CMD ["/fullcycle"]
