#!/bin/bash

set -e

env=development

# For newer version of node, we need the --openssl-legacy-provider option in order to compile. We're
# adding that here, but only if the user has not already specified a NODE_OPTIONS value
export NODE_OPTIONS="$([ -n "$NODE_OPTIONS" ] && echo "$NODE_OPTIONS" || echo "--openssl-legacy-provider")"

while [ "$#" -gt 0 ]; do
  case "$1" in
    -e|--env) env="$2"; shift 2;;
    *) >&2 echo "E: Invalid option '$1'. Valid options are -e|--env"; exit 57;;
  esac
done

# Clean up old artifacts
rm -Rf build/*

# Build new artifacts
npx webpack --env "$env" --mode "$env"

# Copy new artifacts as needed
cp -f build/index.js example/plugin.js

