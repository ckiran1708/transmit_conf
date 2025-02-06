#!/bin/bash

# Define the API endpoint and headers
BASE_API_URL="http://ec2-13-234-63-22.ap-south-1.compute.amazonaws.com:8080/api/v2/mng/delete"
AUTH_HEADER="Authorization: TSToken 99761fe6-94d6-4b86-96c0-62020f4cd43b; tid=management_api"
CONTENT_TYPE="Content-Type: application/json"
CLIENT_VERSION="X-TS-Client-Version: 8.1; [1,2,3,11,12]"

# Check for arguments
if [ $# -eq 0 ]; then
    echo "Usage: $0 --external_connections=<id> | --applications=<id> | --typed_lists=<id>"
    exit 1
fi

# Extract the artifact ID from the input
for arg in "$@"; do
    case $arg in
        --external_connections=*)
            ARTIFACT_TYPE="external_connections"
            ARTIFACT_ID="${arg#*=}"
            ;;
        --applications=*)
            ARTIFACT_TYPE="applications"
            ARTIFACT_ID="${arg#*=}"
            ;;
        --typed_lists=*)
            ARTIFACT_TYPE="typed_lists"
            ARTIFACT_ID="${arg#*=}"
            ;;
        *)
            echo "Invalid argument: $arg"
            exit 1
            ;;
    esac
done

# Check if an ID was provided
if [ -z "$ARTIFACT_ID" ]; then
    echo "Error: No artifact ID provided for $ARTIFACT_TYPE"
    exit 1
fi

# Construct the DELETE request URL with the artifact ID as a query parameter
DELETE_URL="${BASE_API_URL}?aid=${ARTIFACT_ID}"

# Make the DELETE API call
curl --request DELETE "$DELETE_URL" \
    --header "$AUTH_HEADER" \
    --header "$CONTENT_TYPE" \
    --header "$CLIENT_VERSION"

# Print success message
echo "Cleanup request completed for $ARTIFACT_TYPE with ID $ARTIFACT_ID"
