# Stage 1: Build
FROM node:21-alpine3.18 AS build
LABEL NAME="component-build"

# Install build dependencies
RUN apk --no-cache add python3 make g++

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json, package-lock.json, and the workspaces configuration
COPY package.json package-lock.json* ./


# Install dependencies for all workspaces without executing scripts
# Note: The COPY command above does not copy your workspaces yet, so npm ci here will not install workspace dependencies.
# This step is primarily to cache your root dependencies.
RUN npm ci --legacy-peer-deps --loglevel verbose

# Copy the rest of your application code
COPY . .

# Install workspace dependencies
# Assuming your workspace packages do not need to compile native addons, which require build tools.
# If they do, keep the build tools in this stage and consider optimization strategies for compiled dependencies.
RUN npm install --legacy-peer-deps --loglevel verbose



# Stage 2: Runtime
FROM node:21-alpine3.18 AS runtime
LABEL NAME="component-runtime"

# Set non-root user and switch to it
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# Set the working directory
WORKDIR /usr/src/app

# Copy built node modules and compiled code from the previous stage
COPY --from=build --chown=appuser:appgroup /usr/src/app .

# Copy runtime scripts
COPY --chown=appuser:appgroup scripts ./scripts
RUN chmod +x scripts/*.sh

# Execute any setup scripts such as dns.sh if necessary
RUN sh ./scripts/dns.sh

# Set the entrypoint to run the application
ENTRYPOINT ["npm", "start"]
