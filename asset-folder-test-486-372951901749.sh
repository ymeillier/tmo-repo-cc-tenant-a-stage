#! /bin/bash

string=$BASH_SOURCE
# remove the leading "./"
string=${string#./}
#remove .sh:
STRING=${string%.sh}


IFS='-' read -a parts <<< "$STRING"
i=0
for part in "${parts[@]}"; do
    varName=part$i
    declare $varName=$part
    i=$((i+1))
done

#cluster prefix name from filename:
CLUSTER=$part1-$part2-$part3

PARENT_FOLDER=$part4

ASSET_FILENAME=$part1-$part2-$part3-$part4
ASSET=$part2-$part3
cat << EOL >./$ASSET_FILENAME.yaml
apiVersion: resourcemanager.cnrm.cloud.google.com/v1beta1
kind: Folder
metadata:
    namespace: config-control
    labels:
        label-one: "$ASSET"
    name: $ASSET
spec:
    displayName: $ASSET
    folderRef:
        external: "$PARENT_FOLDER"
EOL