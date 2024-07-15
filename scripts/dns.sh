#!/bin/bash

# Print current values of the variables
echo "Current ELASTICIO_API_URI: $ELASTICIO_API_URI"
echo "Current ELASTICIO_SNAPSHOTS_SERVICE_BASE_URL: $ELASTICIO_SNAPSHOTS_SERVICE_BASE_URL"
echo "Current ELASTICIO_SECRET_SERVICE_BASE_URL: $ELASTICIO_SECRET_SERVICE_BASE_URL"
echo "Current ELASTICIO_AMQP_URI: $ELASTICIO_AMQP_URI"

# Replace 127.0.0.1 with host.docker.internal
export ELASTICIO_API_URI=$(echo "$ELASTICIO_API_URI" | sed 's/127\.0\.0\.1/host.docker.internal/')
export ELASTICIO_SNAPSHOTS_SERVICE_BASE_URL=$(echo "$ELASTICIO_SNAPSHOTS_SERVICE_BASE_URL" | sed 's/127\.0\.0\.1/host.docker.internal/')
export ELASTICIO_SECRET_SERVICE_BASE_URL=$(echo "$ELASTICIO_SECRET_SERVICE_BASE_URL" | sed 's/127\.0\.0\.1/host.docker.internal/')
export ELASTICIO_AMQP_URI=$(echo "$ELASTICIO_AMQP_URI" | sed 's/127\.0\.0\.1/host.docker.internal/')

# Replace localhost with host.docker.internal
export ELASTICIO_API_URI=$(echo "$ELASTICIO_API_URI" | sed 's/localhost/host.docker.internal/')
export ELASTICIO_SNAPSHOTS_SERVICE_BASE_URL=$(echo "$ELASTICIO_SNAPSHOTS_SERVICE_BASE_URL" | sed 's/localhost/host.docker.internal/')
export ELASTICIO_SECRET_SERVICE_BASE_URL=$(echo "$ELASTICIO_SECRET_SERVICE_BASE_URL" | sed 's/localhost/host.docker.internal/')
export ELASTICIO_AMQP_URI=$(echo "$ELASTICIO_AMQP_URI" | sed 's/localhost/host.docker.internal/')

# Print changed values of the variables
echo "Changed ELASTICIO_API_URI: $ELASTICIO_API_URI"
echo "Changed ELASTICIO_SNAPSHOTS_SERVICE_BASE_URL: $ELASTICIO_SNAPSHOTS_SERVICE_BASE_URL"
echo "Changed ELASTICIO_SECRET_SERVICE_BASE_URL: $ELASTICIO_SECRET_SERVICE_BASE_URL"
echo "Changed ELASTICIO_AMQP_URI: $ELASTICIO_AMQP_URI"

echo 'changed DNS 127.0.0.1 to host.docker.internal'
