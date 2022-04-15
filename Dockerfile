# we start by using the official node image.  This means we have
# significantly less work to do
FROM node:lts-alpine

# install the amazon cli tools (version 1 since it requires less
# dependencies). This also installs python3 for us.
# this was adapted from here:
# https://stackoverflow.com/questions/61918972/how-to-install-aws-cli-on-alpine
RUN apk add --no-cache \
        python3 \
        py3-pip \
    && pip3 install --upgrade pip \
    && pip3 install --no-cache-dir \
        awscli \
    && rm -rf /var/cache/apk/*

# install hugo (use python to download rather than curl (since curl
# isn't installed) or node (since that doesn't have https support)
RUN cd /usr/bin \
    && python3 -c \
        'from requests import get; import sys; sys.stdout.buffer.write(get("https://github.com/gohugoio/hugo/releases/download/v0.97.0/hugo_extended_0.97.0_Linux-64bit.tar.gz").content)' \
        | tar -xz hugo

# install all our npm dependencies globally
RUN npm install -g \
    autoprefixer \
    postcss \
    postcss-cli \
    postcss-import \
    tailwindcss \
    tw-elements

# finally run the script as our default build
WORKDIR /home/node
CMD cd project && hugo