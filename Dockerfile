Creating a Dockerfile and necessary scripts to containerize a full-stack application can vary greatly depending on the specific technologies used in your stack. However, I'll provide a basic example using a Node.js backend and a React frontend.

First, let's create a Dockerfile for the Node.js backend:

```Dockerfile
# Dockerfile for Node.js backend

# Use official Node.js runtime as a parent image
FROM node:14

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Bundle app source
COPY . .

# Expose port 8080
EXPOSE 8080

# Define command to run the app
CMD [ "node", "server.js" ]
```

Next, let's create a Dockerfile for the React frontend:

```Dockerfile
# Dockerfile for React frontend

# Use official Node.js runtime as a parent image
FROM node:14

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Bundle app source
COPY . .

# Build the app
RUN npm run build

# Use Nginx to serve the build folder
FROM nginx:1.17.1-alpine

# Copy the build folder from build stage to Nginx
COPY --from=0 /usr/src/app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
```

Finally, you can use Docker Compose to manage these services together. Here's a basic `docker-compose.yml` file:

```yaml
version: '3'
services:
  backend:
    build: ./backend
    ports:
      - '8080:8080'
  frontend:
    build: ./frontend
    ports:
      - '80:80'
```

This setup assumes that your project structure looks like this:

```
/myapp
  /backend
    Dockerfile
    server.js
    package.json
  /frontend
    Dockerfile
    src/
    public/
    package.json
  docker-compose.yml
```

To build and run the containers, you would use the command `docker-compose up --build`.