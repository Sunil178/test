#!/bin/bash

newlineToArray() {
	TAGS=$1
	local -n VAR=$2
	SAVEIFS=$IFS
	IFS=$'\n'
	VAR=($TAGS)
	IFS=$SAVEIFS
}

get_git_build_number () {
	CURRENT_TAG=`git tag --points-at HEAD`
	BUILD='build'
	if [[ "$CURRENT_TAG" == *"$BUILD"* ]]; then
		newlineToArray "$CURRENT_TAG" ARRAY
		CURRENT_TAG_ARRAY=()
		for (( i=0; i<${#ARRAY[@]}; i++ ))
		do
			if [[ "${ARRAY[$i]}" == *"$BUILD"* ]]; then
				CURRENT_TAG_ARRAY+=(${ARRAY[$i]})
			fi
		done
		if [ ${#CURRENT_TAG_ARRAY[@]} -gt 1 ]; then
			echo "error: More than one build tags are found"
			exit
		fi
		VALUE=${CURRENT_TAG_ARRAY[0]#*-}
		local -n VAR=$1
		VAR=$VALUE
	else
		TAGS=`git tag`
		newlineToArray "$TAGS" ARRAY
		MAX=0
		for (( i=0; i<${#ARRAY[@]}; i++ ))
		do
			if [[ "${ARRAY[$i]}" == *"$BUILD"* ]]; then
				VALUE=${ARRAY[$i]#*-}
				(($VALUE > MAX)) && MAX=$VALUE
			fi
		done
		local -n VAR=$1
		VAR=$(($MAX + 1))
	fi
}

get_git_build_number TAG_NUMBER
echo "$TAG_NUMBER"
