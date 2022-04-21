FROM node:17

#Create working directory inside docker image
WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

# Bundle your app

COPY . .

EXPOSE 3000

CMD [ "node","server.js" ]