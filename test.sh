#!/bin/bash
#
#  Build Specified Flavor of GER
#
set -x
commits=$(git rev-list HEAD --count origin/main)
echo "Creating Build $commits"
_tags=`git tag --points-at HEAD`
echo "${_tags[0]}"
IFS="\n" read -a tags <<< "$_tags"
ARRAY=()
for i in "${tags[@]}"
do
    echo $i
    ARRAY+=($i)
done
echo "tags=$ARRAY"
exit