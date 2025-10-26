FROM alpine:3.18

# Install dependencies
RUN apk add --no-cache fortune cowsay netcat-openbsd

WORKDIR /app

# Copy the script
COPY wisecow.sh .

# Fix line endings and make executable
RUN sed -i 's/\r$//' wisecow.sh && \
    chmod +x wisecow.sh

EXPOSE 4499

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD nc -z localhost 4499 || exit 1

CMD ["./wisecow.sh"]