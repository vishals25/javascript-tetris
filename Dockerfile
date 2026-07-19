#Just the base of nginx would work because of just html and simple js files, 
#but we can use the alpine version to keep the image size small
FROM nginx:alpine

#To copy the build files from the application  to the nginx server:
COPY . /usr/share/nginx/html

# To access the application from the host machine, we need to expose port 80
EXPOSE 80

#To add a health check to the container, we can use the following command:
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost/ || exit 1


# #To run the application in non-root mode, we can use the following command to run the container:
# FROM nginxinc/nginx-unprivileged:alpine
# COPY . /usr/share/nginx/html
# EXPOSE 8080
