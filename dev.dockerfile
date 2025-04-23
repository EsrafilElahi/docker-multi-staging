# Use Node.js 20 with Alpine (lightweight)
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy package files first for better caching
COPY package.json package-lock.json* ./

# Install dependencies (including devDependencies)
RUN npm install

# Copy all source files
COPY . .

# Environment variables for development
ENV NODE_ENV=development
ENV PORT=3000

# Expose port for dev server
EXPOSE 3000

# Start development server with:
# - Hot reloading (enabled by default)
# - Debugger port (optional)
CMD ["npm", "run", "dev"]

# docker build --file dev.dockerfile --tag nextjs-app .
# docker run -p 3000:3000 -v $(pwd):/app -v /app/node_modules nextjs-app
