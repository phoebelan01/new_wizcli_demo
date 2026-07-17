# wiz-scan ignore
# 1. Using a severely outdated Alpine base image (released in 2019)
# This will bring in vulnerable versions of busybox, apk-tools, and zlib.
FROM alpine:latest

# Adding your organizational label
LABEL wizignore="yes"

# 2. Installing packages from the old 3.10 repositories
# These versions of curl and openssl have multiple known critical CVEs.
RUN apk update && apk add --no-cache \
    curl \
    openssl \
    bash

# 3. Hardcoding a fake secret!
# This ensures your pipeline fails if you have a Secrets policy enabled.
ENV AWS_ACCESS_KEY_ID="AKIAIOSFODNN7EXAMPLE"

RUN echo "Building the extremely vulnerable Alpine application..."

CMD ["sh"]