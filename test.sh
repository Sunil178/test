#!/bin/bash
#
#  Build Specified Flavor of GER
#
set -x
commits=$(git rev-list HEAD --count origin/main)
echo "Creating Build $commits"
_tags=`git tag`
_tags=($_tags)
echo "${_tags[0]}"
