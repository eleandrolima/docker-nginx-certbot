ARG NGINX_VERSION=${NGINX_VERSION}
FROM nginx:${NGINX_VERSION}-alpine

# Copies the custom nginx.conf configuration file to the container
COPY nginx/nginx.conf /etc/nginx/

# Update and install necessary packages
# certbot certbot-nginx are responsible for generating HTTPS
RUN apk update && apk upgrade && \
    apk --update add logrotate openssl bash python3 py3-pip && \
    apk add --no-cache certbot && \
    pip install certbot-nginx

# Remove default NGINX configuration
RUN rm -rf /etc/nginx/conf.d/default.conf

# Add user www-data
RUN adduser -D -H -u 1000 -s /bin/bash www-data -G www-data

# Creates directories for website content and gives respective permissions
RUN mkdir -p /var/www && \
    chown -R www-data:www-data /var/www && \
    chmod 755 -R /var/www

# Create directories for NGINX configurations
RUN mkdir -p /etc/nginx/sites-available /etc/nginx/conf.d && \
    chown -R www-data:www-data /etc/nginx/sites-available /etc/nginx/conf.d

# Sets the working directory for NGINX
WORKDIR /etc/nginx

# Remove unused packages to reduce image size
RUN apk del --no-cache

# Starts NGINX when container runs
CMD ["nginx", "-g", "daemon off;"]