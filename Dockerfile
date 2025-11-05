
# Usamos la imagen oficial de Node.js como base para construir la aplicacion Angular
FROM node:22 AS build

#Directorio de trabajo dentro del contenedor
WORKDIR /app

#Copiamos los archivos de package.json y package-lock.json
COPY package*.json ./

# Instalamos las dependencias del proyecto  
RUN  npm install

# Copiamos el resto de los archivos del proyecto al contenedor
COPY . .

# Construimos la aplicacion Angular en modo produccion
RUN npm run build 

# Fase de ejecucion
# Usamos la imagen oficial de Nginx para servir la aplicacion Angular
FROM nginx:alpine

# Copiamos los archivos construidos desde la fase de compilacion al directorio por defecto de Nginx         
COPY --from=build /app/dist/reservas-front usr/share/nginx/html

# Exponemos el puerto 80 para el trafico HTTP   
EXPOSE 80



