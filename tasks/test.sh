#!/bin/bash

declare PT_environment
environment=$PT_environment

if [ -e "/etc/sysconfig/pe-puppetserver" ] || [ -e "/etc/default/pe-puppetserver" ] 
then
  if [ -f "/root/.puppetlabs/token" ]
  then  
    if [ "$environment" != 'all' ]
    then
      echo "Deploying environment: $environment"
      /opt/puppetlabs/bin/puppet-code deploy $environment --wait -l debug 2>&1
    else
      /opt/puppetlabs/bin/puppet-code deploy --all --wait -l debug 2>&1
    fi
  else
    echo "Please follow the documentation here: <> to create a new token"
    exit 1 
  fi
else
  echo "Node is not a Pupper Master, please select node which runs the pe-puppetserver Service"
  exit 1  
fi    

