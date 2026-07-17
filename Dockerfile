# wiz-scan ignore
FROM alpine:latest

# Adding your requested label
LABEL wizignore="yes"

# Example application setup
RUN echo "Building the application..."

CMD ["sh"]