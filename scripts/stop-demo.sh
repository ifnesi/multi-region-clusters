#!/bin/bash

echo
echo "Check if docker is running..."
if (! docker stats --no-stream > /dev/null 2>&1); then
    echo "ERROR: Please start Docker Desktop, then run the '$0' script"
    echo ""
    exit 1
fi
echo

echo "Stopping up docker compose..."
docker-compose down
