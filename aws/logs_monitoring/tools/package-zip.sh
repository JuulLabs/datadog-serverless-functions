#!/bin/bash

set -e

# Move into the tools directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $DIR

# Read the desired version
if [ -z "$1" ]; then
    echo "Must specify a desired version number"
    exit 1
else
    if [[ $1 =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        VERSION=$1
    elif [[ $1 =~ refs/tags/[0-9]+\.[0-9]+\.[0-9]+ ]]; then
        VERSION="$(echo $1 | cut -d/ -f3)"
    else
        echo "Must use a semantic version, e.g., 3.1.4"
        exit 1
    fi
fi

zip -r aws-dd-forwarder-$VERSION.zip ../lambda_function.py
