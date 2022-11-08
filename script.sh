#!/bin/bash

rm -rf _status
mkdir _status
oc get pods -A -ojson \
    | jq '
        .items[] 
        | "_status/\(.metadata.namespace)/\(.metadata.name)"
    ' -r  \
    | xargs -I@ bash -c \
    '
        mkdir -p @ \
        && \
        dd if=/dev/zero of=@/$(basename @) bs=1KB count=$(
            oc adm top pod -n $(basename $(dirname @)) $(basename @) --no-headers 2>/dev/null \
            | awk '"'"'{print substr($3, 1, length($3) - 2)}'"'"'
        )
        '
