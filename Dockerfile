FROM node:22-alpine as react-build

WORKDIR /app

COPY package*.json ./

RUN npm ci --ignore-scripts --no-audit --no-fund

COPY . .

ENV NODE_ENV production

RUN npm run build

FROM httpd:2.4-alpine

COPY --from=react-build /app/dist /usr/local/apache2/htdocs/

EXPOSE 80

CMD ["httpd-foreground"]
