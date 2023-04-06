# Use the official httpd image as the base image
FROM registry.access.redhat.com/ubi8/httpd-24:1-256

# Copy the contents of the local directory into the container
COPY index.html /var/www/html/index.html
COPY artifacts/* /var/www/html/

# Expose the port on which the httpd server will listen
EXPOSE 8080

# Start the httpd server
CMD ["/usr/bin/run-httpd"]
