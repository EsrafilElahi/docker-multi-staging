# FROM node:14-alpine AS builder
FROM node:16.19.0 AS builder

WORKDIR /app
# Cache and Install dependencies
COPY package.json .
COPY yarn.lock .
RUN yarn install --production

# Copy all files
COPY . .

RUN yarn next build

# Bundle static assets with nginx
# FROM nginx:1.21.0-alpine as production

# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Static build
COPY --from=builder /app/.next /usr/share/nginx/html/

# Default port exposure
EXPOSE 80

# Copy .env file and shell script to container
# WORKDIR /usr/share/nginx/html
# COPY ./env .
COPY .env .

# Start Nginx server
# CMD ["nginx", "-g", "daemon off;"]
CMD yarn start