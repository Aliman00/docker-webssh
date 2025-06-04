FROM python:3.12-alpine

# Create a non-root user
RUN addgroup -g 1001 webssh && \
    adduser -D -u 1001 -G webssh webssh

# Update system packages
RUN apk update && apk upgrade --no-cache && \
    apk add --no-cache --virtual .build-deps \
        gcc \
        musl-dev \
        libffi-dev \
        openssl-dev && \
    apk add --no-cache \
        openssl \
        ca-certificates

# Install webssh
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir webssh

# Clean up build dependencies
RUN apk del .build-deps

# Switch to non-root user
USER webssh

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:8888/ || exit 1

EXPOSE 8888


ENTRYPOINT ["wssh", "--port=8888", "--address=0.0.0.0"]