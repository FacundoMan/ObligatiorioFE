FROM node:18.12.1-buster-slim AS builder

WORKDIR /app
COPY package.json package-lock.json ./
COPY public/ public/
COPY src/ src/
RUN npm ci
RUN npm run build

FROM node:16.15.0 as build
WORKDIR /var/app
COPY . .

RUN npm install && npm run build

FROM nginx:1.23.3
EXPOSE 9000

COPY --from=build /var/app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
WORKDIR /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]



