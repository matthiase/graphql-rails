FROM node:12.13.1-alpine

ENV APP_PATH /client
ENV PATH $APP_PATH/node_modules/.bin:$PATH

RUN apk add git

WORKDIR $APP_PATH

COPY package*.json ./
RUN yarn install
RUN yarn global add @vue/cli@4.0.5

EXPOSE 8080

CMD ["npm", "run", "serve"]
