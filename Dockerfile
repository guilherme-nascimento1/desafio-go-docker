# Usar a imagem oficial do Go como build
FROM golang:alpine AS builder

# Definir diretório de trabalho
WORKDIR /app

# Copiar código fonte
COPY main.go .

# Criar módulo Go
RUN go mod init fullcycle

# Compilar o código Go
RUN go build -o fullcycle main.go

# Criar imagem mínima usando 'scratch'
FROM scratch

# Copiar binário compilado da etapa anterior
COPY --from=builder /app/fullcycle /fullcycle

# Definir comando de execução
CMD ["/fullcycle"]
