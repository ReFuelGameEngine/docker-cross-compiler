#!/bin/bash
if [-z "$1"]
then
    $1 = $(dirname "$0")
fi

if [ -z "$NUGET_API_KEY" ]
then
    echo "Please define NUGET_API_KEY"
    exit 1
fi

if [ -z "$NUGET_USER_NAME" ]
then
    echo "Please define NUGET_USER_NAME"
    exit 1
fi

if [ -z "$NUGET_INDEX" ]
then
    echo "Please define NUGET_INDEX"
    exit 1
fi

cd $1
dotnet nuget add source \
    -n ReFuel -u "$NUGET_USER_NAME" -p "$NUGET_API_KEY" \
    --store-password-in-clear-text \
    "$NUGET_INDEX"
dotnet nuget push -s ReFuel bin/*/*.nupkg
