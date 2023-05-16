#!/bin/bash
echo "Env vars: NAME=$RC_WORKER_NAME, TOKEN=$RC_WORKER_LINK_TOKEN, ENDPOINT=$RC_CONDA_ENDPOINT"
name=$RC_WORKER_NAME
token=$RC_WORKER_LINK_TOKEN
endpoint=$RC_CONDA_ENDPOINT

echo "Linking the Agent with name $name and token $token"
./bin/robocorp-workforce-agent-core link $token --name $name --instance-path ./instance --log-level TRACE
echo "Linking succeeded"

echo "Starting the Agent..."
exec ./bin/robocorp-workforce-agent-core start --instance-path ./instance --envEndpoint $endpoint --log-level TRACE --run-once