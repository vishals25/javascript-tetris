#Just the base of nginx would work because of just html and simple js files, 
#but we can use the alpine version to keep the image size small
#
#Updated from FROM nginx:alpine to FROM nginxinc/nginx-unprivileged:alpine 
#to run the container as a non-root user for security reasons
FROM nginxinc/nginx-unprivileged:alpine

#To copy the build files from the application  to the nginx server:
COPY . /usr/share/nginx/html

#The base image already runs as UID 101, but Trivy's DS-0002 check only parses
#this file, so the USER line has to be explicit to satisfy it
USER 101

# To access the application from the host machine, we need to expose port 8080
EXPOSE 8080

#To add a health check to the container, we can use the following command:
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -q --spider http://localhost:8080/ || exit 1

