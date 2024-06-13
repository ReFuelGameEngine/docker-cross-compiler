#!/bin/bash
if [-z "$1"]
then
    $1 = $(dirname "$0")
fi

if [ -z "$QUIK_API_KEY" ]
then
    echo "Please define QUIK_API_KEY"
    exit 1
fi

cd $1
dotnet nuget add source \
    -n QUIK -u themixedupstuff -p "$QUIK_API_KEY" \
    --store-password-in-clear-text \
    https://git.mixedup.dev/api/packages/QUIK/nuget/index.json 
dotnet nuget push -s QUIK bin/*/*.nupkg
