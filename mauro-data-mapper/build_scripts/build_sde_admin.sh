#!/bin/bash

precompiledBuild(){
   echo 'Using pre-compiled source'

  if [[ $SDE_ADMIN_VERSION == *SNAPSHOT ]]
  then
    SDE_ADMIN_LIBRARY='artifacts-snapshots'
   else
    SDE_ADMIN_LIBRARY='artifacts'
   fi

  SDE_ADMIN_URL="https://mauro-repository.com/${SDE_ADMIN_LIBRARY}/mauroDataMapper/sde-admin-ui/sde-admin-ui-${SDE_ADMIN_VERSION}.tgz"
  SDE_RESEARCHER_API_ENDPOINT="http://localhost:8093/"

  echo "Downloading precompiled sources ${SDE_ADMIN_URL}"

  cd /opt || exit
  curl -LO "$SDE_ADMIN_URL"
  tar xzf "sde-admin-ui-${SDE_ADMIN_VERSION}.tgz"
  
  mkdir $SDE_ADMIN_BUILD_HOME
  cp -r sde-admin-ui-${SDE_ADMIN_VERSION}/* $SDE_ADMIN_BUILD_HOME

  ls $SDE_ADMIN_BUILD_HOME
  
#  find "$MDM_EXPLORER_BUILD_HOME" -name main.*.js -exec sed -e "s|apiEndpoint:\"api\",|apiEndpoint:\"${MDM_EXPLORER_API_ENDPOINT}\",|g" -i {} \;
  find "$SDE_ADMIN_BUILD_HOME" -name main.*.js -exec sed -e "s|baseUrl:\"api\"|baseUrl:\"${SDE_RESEARCHER_API_ENDPOINT}\"|g" -i {} \;

}

precompiledBuild
