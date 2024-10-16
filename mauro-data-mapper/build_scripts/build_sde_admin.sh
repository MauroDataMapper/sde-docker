#!/bin/bash

precompiledBuild(){
    echo 'Using pre-compiled source'
    echo SDE ADMIN BUILD HOME $SDE_ADMIN_BUILD_HOME

    SDE_ADMIN_API_ENDPOINT="http://localhost:8093/"

  if [ -n "$( ls -A '/prebuilt-sde-admin' )" ]; then
    echo "A pre-existing build for SDE Admin System has been provided - using that instead of downloading a release"
    cp -r /prebuilt-sde-admin/* "$SDE_ADMIN_BUILD_HOME"

    ls $SDE_ADMIN_BUILD_HOME

    grep 'baseUrl:""' $SDE_ADMIN_BUILD_HOME/*
    grep 'baseUrl:"api"' $SDE_ADMIN_BUILD_HOME/*
    
  else
    echo "Not using a pre-existing build for SDE Admin System - downloading a release..."

    if [[ $SDE_ADMIN_VERSION == *SNAPSHOT ]]
     then
      SDE_ADMIN_LIBRARY='artifacts-snapshots'
     else
      SDE_ADMIN_LIBRARY='artifacts'
    fi

    SDE_ADMIN_URL="https://mauro-repository.com/${SDE_ADMIN_LIBRARY}/mauroDataMapper/sde-admin-ui/sde-admin-ui-${SDE_ADMIN_VERSION}.tgz"

    echo "Downloading precompiled sources ${SDE_ADMIN_URL}"

    cd /opt || exit
    curl -LO "$SDE_ADMIN_URL"
    tar xzf "sde-admin-ui-${SDE_ADMIN_VERSION}.tgz"
   
    mkdir $SDE_ADMIN_BUILD_HOME
    cp -r sde-admin-ui-${SDE_ADMIN_VERSION}/* $SDE_ADMIN_BUILD_HOME

  fi
   
#  find "$MDM_EXPLORER_BUILD_HOME" -name main.*.js -exec sed -e "s|apiEndpoint:\"api\",|apiEndpoint:\"${MDM_EXPLORER_API_ENDPOINT}\",|g" -i {} \;
   find "$SDE_ADMIN_BUILD_HOME" -name main.*.js -exec sed -e "s|baseUrl:\"api\"|baseUrl:\"${SDE_ADMIN_API_ENDPOINT}\"|g" -i {} \;

}

precompiledBuild
