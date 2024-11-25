FROM node:20-alpine as build

WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build

FROM node:20-alpine as production
ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /app

COPY package.json ./
RUN npm install --only=production

COPY --from=build /app/dist ./dist

CMD ["node", "dist/main"]

EXPOSE 3000