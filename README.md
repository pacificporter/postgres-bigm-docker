# Dockerfile for pg_bigm

PostgreSQL with pg_bigm extension for full-text search.

## Supported Platforms

- linux/amd64
- linux/arm64

## Multi-platform Build

### Prerequisites

Ensure you have a buildx builder instance that supports multi-platform builds:

```bash
# List existing builders
docker buildx ls

# If needed, create a new builder
docker buildx create --name multiplatform --use
docker buildx inspect --bootstrap
```

### Build and Push

Build for both amd64 and arm64 platforms:

```bash
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t pacificporter/postgres-bigm:16.11 \
  --push \
  .
```

## Usage

```bash
docker pull pacificporter/postgres-bigm:16.11
```

The appropriate platform image will be automatically selected based on your system architecture.
