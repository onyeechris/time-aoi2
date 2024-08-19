# Use an official Node.js runtime as a parent image
FROM node:14

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the package.json and package-lock.json (if available)
COPY package*.json ./

# Install the app dependencies
RUN npm install

# Bundle app source code inside the Docker image
COPY . .

# Expose the port that the app will run on
EXPOSE 3000

# Command to run the app
CMD [ "node", "index.js" ]
