#!/bin/bash

URL="$1"

if [ -z "$URL" ]; then
    echo "Usage: $0 <url>"
    exit 1
fi

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

HTTP_STATUS=$(curl -k -s -o /dev/null -w "%{http_code}" "$URL")

echo "=========================================="
echo "Application Health Check"
echo "=========================================="
echo "URL: $URL"
echo "Checked At: $TIMESTAMP"
echo "HTTP Status Code: $HTTP_STATUS"

if [[ "$HTTP_STATUS" =~ ^2[0-9][0-9]$ ]]; then
    echo "Application Status: UP"
    exit 0
else
    echo "Application Status: DOWN"
    exit 1
fi