# Use a basic web server image
FROM nginx:latest

# Copy our web app to the server folder
COPY index.html /usr/share/nginx/html/

# Expose port 80 so we can access the web app
EXPOSE 80

# Start the web server
CMD ["nginx", "-g", "daemon off;"]
 
 
