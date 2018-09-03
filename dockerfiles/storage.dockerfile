ARG NODE_VERSION=8-alpine

FROM node:${NODE_VERSION}

WORKDIR /app

ADD ./package*.json ./

RUN npm install

ENV NODE_ENV=production
ADD . .

RUN npm prune

# multi-stage build
FROM node:${NODE_VERSION}

WORKDIR /app

RUN apk update && apk add --no-cache \
        graphicsmagick \
		openssl

COPY --from=0 /app .

CMD sleep 10 && npm start
