# we start by using the official node image.  This means we have
# significantly less work to do
FROM node:lts-alpine

# install stuff via apk
# 1) hugo (this is actually hugo extended)
# 2) the amazon cli tools (version 1 since it requires less
# dependencies). This also installs python3 for us.
# this was adapted from here:
# https://stackoverflow.com/questions/61918972/how-to-install-aws-cli-on-alpine
RUN apk add --no-cache \
        hugo \
        python3 \
        py3-pip \
    && pip3 install --upgrade pip \
    && pip3 install --no-cache-dir \
        awscli \
    && rm -rf /var/cache/apk/*

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