#!/bin/bash

echo "flowId: ${FLOW_ID}, stepId: ${STEP_ID}"

# Ensure service_id is lowercase
service_id="nodejs-debug-${FLOW_ID,,}"
service_id=${service_id:0:63} # Ensure service_id does not exceed 63 characters

# Correctly capture the output of the kubectl command into the variable
pod_id=$(kubectl get pods -l flowId=${FLOW_ID},stepId=${STEP_ID} -o=jsonpath='{.items[*].metadata.name}' -n flows)

# Check if pod_id is empty
if [ -z "$pod_id" ]; then
  echo "No pod found for flowId=${FLOW_ID}, stepId=${STEP_ID}. Exiting script."
  exit 1
fi

echo "service_id: ${service_id}"
echo "pod_id: ${pod_id}"

echo "deleting service ${service_id}"
kubectl delete service ${service_id} -n flows 

echo "exposing pod ${pod_id} as service ${service_id}"
kubectl expose pod ${pod_id} --port=9229 --target-port=9229 --name=${service_id} -n flows 

echo "forwarding port 9229"
# Start port-forward in background
kubectl port-forward service/${service_id} 9229:9229 -n flows & \
PF_PID=$! \

echo "kubectl port-forward Process : ${PF_PID} \n\nPress CTRL-C to stop port forwarding and exit the script"
wait

kill $(lsof -t -i:9229)

# Remember to kill the port-forward process later in your script or at some other point
# kill $PF_PID
