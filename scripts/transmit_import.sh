#!/bin/bash

# How It Works:
# Checks if an argument is provided.
# Parses the flag and determines which JSON file to use.
# Verifies that the JSON file exists.
# Executes the curl request with the JSON file as the request body.
# Displays a success message after the request completes.



# Define the base directory
BASE_DIR="/apps/config/packages"

# Define the API endpoint and headers
API_URL="http://ec2-13-234-63-22.ap-south-1.compute.amazonaws.com:8080/api/v2/mng/import"
AUTH_HEADER="Authorization: TSToken 99761fe6-94d6-4b86-96c0-62020f4cd43b; tid=management_api"
CONTENT_TYPE="Content-Type: application/json"
CLIENT_VERSION="X-TS-Client-Version: 8.1; [1,2,3,11,12]"

# Check for arguments
if [ $# -eq 0 ]; then
    echo "Usage: $0 --external_connections=true | --applications=true | --typed_lists=true"
    exit 1
fi

# Extract the flag
for arg in "$@"; do
    case $arg in
        --external_connections=true)
            JSON_FILE="$BASE_DIR/external_connections.json"
            ;;
        --applications=true)
            JSON_FILE="$BASE_DIR/applications.json"
            ;;
        --typed_lists=true)
            JSON_FILE="$BASE_DIR/typedllists.json"
            ;;
        *)
            echo "Invalid argument: $arg"
            exit 1
            ;;
    esac
done

# Check if the JSON file exists
if [ ! -f "$JSON_FILE" ]; then
    echo "Error: JSON file $JSON_FILE not found!"
    exit 1
fi

# Make the API request with the JSON data
curl --location "$API_URL" \
    --header "$AUTH_HEADER" \
    --header "$CONTENT_TYPE" \
    --header "$CLIENT_VERSION" \
    --data @"$JSON_FILE"

# Print success message
echo "Import request completed using $JSON_FILE"



