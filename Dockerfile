FROM node:21-alpine3.17
WORKDIR /app

ARG ENV=prod
ENV ENV=$ENV

COPY package.json .

# Install npm@10.2.3
RUN npm install 

# Install nodemon conditionally
RUN if [ "$ENV" = "dev" ]; then npm install -g nodemon; fi

COPY . .

ENV PORT 3000
EXPOSE $PORT

# Use different CMD commands based on the environment
CMD if [ "$ENV" = "dev" ]; then npx nodemon -L index.js; else npm start; fi