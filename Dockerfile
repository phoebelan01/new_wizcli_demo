# wiz-scan ignore
# 1. Using a severely outdated base image (Ubuntu 18.04)
# This alone will trigger dozens of OS-level vulnerabilities.
FROM ubuntu:18.04

# Adding your organizational label
LABEL wizignore="yes"

# 2. Installing specific, outdated packages with known CVEs
# (curl and bash from the 18.04 era have multiple known exploits)
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl=7.58.0-2ubuntu3 \
    bash=4.4.18-2ubuntu1 \
    && rm -rf /var/lib/apt/lists/*

# 3. Bonus: Hardcoding a fake secret!
# If your policy includes Secrets scanning, Wiz CLI will flag this too.
ENV AWS_ACCESS_KEY_ID="AKIAIOSFODNN7EXAMPLE"

RUN echo "Building the extremely vulnerable application..."

CMD ["bash"]