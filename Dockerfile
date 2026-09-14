# wiz-scan ignore
FROM alpine:3.10

LABEL wizignore="yes"

# 1. Package Vulnerabilities (Managed OS packages via apk)
RUN apk update && apk add --no-cache \
    curl \
    openssl \
    bash

# 2. File Path Vulnerabilities (Unmanaged binaries & Java archives placed directly on disk)
RUN mkdir -p /opt/vulnerable-files && \
    wget https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-core/2.14.1/log4j-core-2.14.1.jar -O /opt/vulnerable-files/log4j-core-2.14.1.jar

# 3. Hardcoded Secret (For pipeline policy checks)
ENV AWS_ACCESS_KEY_ID="AKIAIOSFODNN7EXAMPLE"

CMD ["sh"]
