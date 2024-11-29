# Use a lightweight nginx base image
FROM nginx:alpine

# Set the working directory inside the container
WORKDIR /usr/share/nginx/html

# Remove default nginx contents
RUN rm -rf ./*

# Copy the build output from your local machine into the container
COPY ./build .

# Expose port 80 for web traffic
EXPOSE 80

# Run nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
