FROM node:12
RUN mkdir -p /home/node/app
#RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
WORKDIR /home/node/app
COPY . .
#RUN apt update -y &&  apt install -y build-essentials
RUN npm install pm2@4.5.6 -g
RUN npm install typescript@3.9.7 -g

#RUN npm install node-gyp -g
#RUN npm install bcrypt -g
#RUN apt update -y && apt-get install build-essential -y && sudo apt-get install build-essential
#RUN npm clean-install
#RUN npm install --save bcrypt-nodejs && npm uninstall --save bcrypt
RUN mkdir uploads -p 
RUN mkdir temp -p 
RUN yarn install --ignore-engines
RUN yarn run initial:online:staging
RUN tsc -v
RUN tsc
RUN cp -r projects/docusign/config/private.txt dist/projects/docusign/config/
RUN cp -r projects/docusign/config/prodPrivate.txt dist/projects/docusign/config/
CMD ["pm2-runtime", "pm2env-staging.json"]