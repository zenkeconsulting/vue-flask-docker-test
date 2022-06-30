# build stage
FROM node:lts-alpine as build-stage

RUN apk -U upgrade \
    && apk add git

WORKDIR /app
COPY package*.json ./
COPY . .

RUN npm install
RUN npm run build
CMD npm run serve -- --port 8080

# Lints Code
FROM build-stage as lint-stage
WORKDIR /app
COPY --from=build-stage /app/ .
RUN npm run lint

# production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]





