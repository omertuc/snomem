#!/usr/bin/bash

CLUSTER_ID=a6038ede-6757-4103-9b7d-abe965e1c86f

# ocm login --url https://api.integration.openshift.com --token="<from https://qaprodauth.console.redhat.com/openshift/token?env=integration>"

curl -s -X PATCH "https://api.integration.openshift.com/api/assisted-install/v2/clusters/$CLUSTER_ID/install-config" -H "Authorization: Bearer $(ocm token)" --json '"{\"capabilities\":{\"baselineCapabilitySet\":\"None\"}}"'


curl -s "https://api.integration.openshift.com/api/assisted-install/v2/clusters/$CLUSTER_ID" -H "Authorization: Bearer $(ocm token)" | jq '.install_config_overrides'

curl -s "https://api.integration.openshift.com/api/assisted-install/v2/clusters/$CLUSTER_ID/downloads/files?file_name=install-config.yaml" -H "Authorization: Bearer $(ocm token)"


