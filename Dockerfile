# Use the official Amazon Linux 2 Docker image as the base image
FROM amazonlinux:2

# Update the package manager and install necessary dependencies
RUN yum update -y && \
    yum install -y wget unzip

# Install Node.js
RUN curl -sL https://rpm.nodesource.com/setup_16.x | bash - && \
yum install -y nodejs

# Verify the installed Node.js version
RUN node -v

# Install AWS CLI v2
RUN curl "https://d1vvhvl2y92vvt.cloudfront.net/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

# Install Chrome
RUN curl -sS -o /tmp/google-chrome-stable.rpm https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm && \
    yum install -y /tmp/google-chrome-stable.rpm && \
    rm /tmp/google-chrome-stable.rpm

# Remove the package or file
#RUN yum remove -y nodejs
#RUN yum remove -y unzip
RUN yum remove -y wget
#RUN yum remove -y ./google-chrome-stable_current_*.rpm


#<------------------------------------------------------ ubuntu ----------------------------------------->
# Base image
FROM ubuntu:latest

# Update package lists
RUN apt-get update

# Install necessary dependencies
RUN apt-get install -y curl wget gnupg ca-certificates


# Install Node.js
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs

# Install AWS CLI
RUN apt-get install -y unzip
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

# Install Google Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
RUN apt-get update
RUN apt-get install -y google-chrome-stable