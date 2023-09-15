# Use an official Node.js runtime as the base image
FROM node:14

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and yarn.lock into the container
COPY package.json yarn.lock ./

# Set environment variable to bypass Husky during installation
ENV HUSKY=0

# Install dependencies
RUN yarn install

# Copy the rest of the application into the container
COPY . .

# Build the project (if required)
RUN yarn build

# Remove dev dependencies and install only production dependencies (optional step for reducing image size)
RUN rm -rf node_modules && yarn install --production

# Expose the port the app runs on
EXPOSE 5173

# Specify the command to run when the container starts
CMD ["yarn", "--host", "0.0.0.0"]
