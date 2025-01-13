#!/bin/bash

precompiledBuild(){
   echo 'Using pre-compiled source'
   
  if [ -n "$( ls -A '/prebuilt-explorer' )" ]; then
    echo "A pre-existing build for Mauro Explorer has been provided - using that instead of downloading a release"
    cp -r /prebuilt-explorer/* "$MDM_EXPLORER_BUILD_HOME"
  
  else
   echo "Not using a pre-existing build for Mauro Explorer - downloading a release..."

   if [[ $MDM_EXPLORER_VERSION == *SNAPSHOT ]]
     then
       MDM_EXPLORER_LIBRARY='artifacts-snapshots'
     else
       MDM_EXPLORER_LIBRARY='artifacts'
     fi

    MDM_EXPLORER_URL="https://mauro-repository.com/${MDM_EXPLORER_LIBRARY}/mauroDataMapper/mdm-explorer/mdm-explorer-${MDM_EXPLORER_VERSION}.tgz"

    echo "Downloading precompiled sources ${MDM_EXPLORER_URL}"

    cd /opt || exit
    curl -LO "$MDM_EXPLORER_URL"
    tar xzf "mdm-explorer-${MDM_EXPLORER_VERSION}.tgz"
    ls
    rm -r "$MDM_EXPLORER_BUILD_HOME"
    mkdir "$MDM_EXPLORER_BUILD_HOME"
    cp -r "mdm-explorer-${MDM_EXPLORER_VERSION}"/* "$MDM_EXPLORER_BUILD_HOME"

  fi

  MDM_EXPLORER_API_ENDPOINT="http://portaltest.thamesvalleyandsurreyhealthandcaredata.nhs.uk/api"
  SDE_RESEARCHER_API_ENDPOINT="http://portaltest.thamesvalleyandsurreyhealthandcaredata.nhs.uk/researcher-api/"

  find "$MDM_EXPLORER_BUILD_HOME" -name main.*.js -exec sed -e "s|apiEndpoint:\"api\"|apiEndpoint:\"${MDM_EXPLORER_API_ENDPOINT}\"|g" -i {} \;
  find "$MDM_EXPLORER_BUILD_HOME" -name main.*.js -exec sed -e "s|baseUrl:undefined|baseUrl:\"${SDE_RESEARCHER_API_ENDPOINT}\"|g" -i {} \;

}

precompiledBuild
