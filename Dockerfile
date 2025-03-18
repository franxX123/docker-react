
# NOTE: This is a multi-step build process for creating a build file from
# our node-based server. Another container using nginx is then used to
# allow nginx to serve files.
FROM node:16-alpine as builder

WORKDIR "/app"
COPY package.json .
RUN npm install
COPY . .

RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html