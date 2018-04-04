FROM node:6.14.1-alpine
LABEL maintainer="c.ramirez@gbh.com.do"

EXPOSE 3000

RUN apk add --update tini && mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY . .

RUN npm install && npm cache clean --force

CMD /sbin/tini -- node ./bin/www
