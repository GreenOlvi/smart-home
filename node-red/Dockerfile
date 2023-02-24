FROM nodered/node-red
WORKDIR /data
COPY ./data/package.json .
RUN npm install --unsafe-perm=true --no-update-notifier --no-fund --only=production
COPY ./data/* ./
WORKDIR /usr/src/node-red
