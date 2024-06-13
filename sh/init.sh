#!/bin/bash

# Change to source directory
cd $HOME/src

export QUIK_SRC=$PWD
export QNUGET_LOCAL=QuikLocal
export QNUGET_LOCAL_PATH=$QUIK_SRC/nuget_repo
# export QNUGET_REMOTE=nuget

# Create nuget repository.
mkdir -p $QUIK_SRC/nuget_repo
nuget sources Add -Name $QNUGET_LOCAL -Source $QNUGET_LOCAL_PATH -NonInteractive
