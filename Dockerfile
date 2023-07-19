
FROM node:16.15.0 as build
WORKDIR /var/app
COPY . .

RUN npm install && npm run build

FROM nginx:1.23.3
EXPOSE 9000

COPY --from=build /var/app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
WORKDIR /usr/share/nginx/html




