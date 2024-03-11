# ======================================== Stage 1: install dependencies
FROM node:17-alpine AS deps

WORKDIR /app

COPY package*.json .

ARG NODE_ENV
ENV NODE_ENV $NODE_ENV
 
RUN npm install --loglevel verbose

# ======================================== Stage 2: build
FROM node:17-alpine AS builder

WORKDIR /app

# from deps stage - just copy the node_modules folder 
COPY --from=deps /app/node_modules ./node_modules

# copy rest important files to build stage
COPY . .

RUN npm run build

# ======================================== Stage 3: run after build 
FROM node:17-alpine as runner

WORKDIR /app

COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./
COPY --from=builder /app/next.config.js ./

CMD ["npm", "run", "start"]
