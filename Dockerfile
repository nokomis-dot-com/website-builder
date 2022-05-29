# this image has both node and hugo-extended installed.
# (it's 420MB, so a little on the large side.  Oh well.)
FROM peaceiris/hugo:latest-full

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
ENTRYPOINT [ "/usr/bin/hugo" ]