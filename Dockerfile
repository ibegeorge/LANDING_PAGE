# Use the official Nginx base image
FROM nginx:alpine

# Set a working directory
WORKDIR /usr/share/nginx/html

# Remove the default nginx index page
RUN rm -rf ./*

# Copy your project files (HTML + CSS) into the container
COPY . .

# Expose port 80 to the outside
EXPOSE 80

# Nginx will automatically start via the base image's entrypoint
