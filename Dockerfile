# Stage 1: Build
FROM node:16.16.0-alpine AS build

WORKDIR /app
COPY fultimator/package*.json ./
RUN npm ci
COPY fultimator/ .
RUN npm config set timeout 60000
RUN npm run build

# Stage 2: Production
FROM node:16.16.0-alpine

WORKDIR /app
COPY --from=build /app/build ./build
COPY fultimator/package*.json ./
RUN npm ci --only=production

EXPOSE 3000
CMD ["npm", "start"]
