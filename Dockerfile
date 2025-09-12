# Étape 1 : construire l'application Angular
FROM node:18-alpine AS build
WORKDIR /usr/src/app

# Installer Angular CLI compatible avec Angular 19
RUN npm install -g @angular/cli@19

# Copier les fichiers de dépendances et installer
COPY package*.json ./
RUN npm install --legacy-peer-deps

# Copier tout le projet et builder en production
COPY . .
RUN ng build --configuration production

# Étape 2 : servir l'application avec Nginx
FROM nginx:latest
COPY --from=build /usr/src/app/dist/angularexampleapp/browser/en/ /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
