# Use a minimal base image
FROM alpine:latest

# Set the working directory inside the container
WORKDIR /apps/config/packages

# Copy all required JSON files to the working directory

COPY applications/applications.json /apps/config/packages/
COPY external_connections/external_connections.json /apps/config/packages/
COPY typed_lists/typedllists.json /apps/config/packages/

# Copy the import script to the container
COPY import.sh /apps/config/packages/

# Give execute permissions to the script
RUN chmod +x /apps/config/packages/import.sh

# Run the import script upon container start
CMD ["/bin/sh", "/apps/config/packages/import.sh"]
