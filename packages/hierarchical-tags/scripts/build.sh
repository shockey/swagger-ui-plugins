#!/bin/bash

set -e

env=development

while [ "$#" -gt 0 ]; do
  case "$1" in
    -e|--env) env="$2"; shift 2;;
    *) >&2 echo "E: Invalid option '$1'. Valid options are -e|--env"; exit 57;;
  esac
done

rm -Rf build/*
npx webpack --env "$env" --mode "$env"
rm example/swagger-ui-*.js &>/dev/null || true
cp -f build/swagger-ui*.js example/
cd example
ln -snf swagger-ui*.js plugin.js

