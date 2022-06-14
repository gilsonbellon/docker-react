FROM node:18-alpine as builder
WORKDIR /app
RUN npm install --location=global npm@8.12.1
COPY package.json .
RUN npm config set unsafe-perm true
RUN npm install --force
COPY . .
RUN npm run build

FROM nginx:stable-alpine
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]`