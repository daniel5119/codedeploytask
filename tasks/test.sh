#!/bin/bash

declare PT_environment
environment=$PT_environment

if ([ -e "/etc/sysconfig/pe-puppetserver" ] || [ -e "/etc/default/pe-puppetserver" ]) && [-f /etc/puppetlabs/puppetserver/conf.d/code-manager.conf] 
then
  if [ -f "/root/.puppetlabs/token" ]
  then  
    if [ "$environment" != 'all' ]
    then
      echo "Attempting to deploy environment: $environment."
      /opt/puppetlabs/bin/puppet-code deploy $environment --wait -l debug 2>&1
    else
      echo "Attempting to deploy all environments."
      /opt/puppetlabs/bin/puppet-code deploy --all --wait -l debug 2>&1
    fi
  else
    echo "Please follow the documentation here: <> to create a new token"
    exit 1 
  fi
else
  echo "Node is not a MoM, please select node which runs the pe-puppetserver Service."
  exit 1  
fi    

