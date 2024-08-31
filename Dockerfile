FROM node:20-alpine

# Set environment variables
ENV NODE_ENV=production
ENV NODE_TLS_REJECT_UNAUTHORIZED=0

# Set WORKDIR
WORKDIR /app

# Copy only package.json and package-lock.json first
COPY --chown=node:node package*.json ./

# Update NPM to the latest version
RUN npm install -g npm@latest

# Install the latest versions of dependencies
RUN npm install --production --legacy-peer-deps

# Copy the rest of the project files
COPY --chown=node:node . .

# Copy entrypoint script
COPY docker/entrypoint /entrypoint

# Make entrypoint executable
RUN chmod +x /entrypoint

# Switch to a non-root user
USER node

# Start the application
ENTRYPOINT ["/entrypoint"]
