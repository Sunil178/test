#!/bin/bash

newlineToArray() {
	TAGS=$1
	local -n VAR=$2
	SAVEIFS=$IFS
	IFS=$'\n'
	VAR=($TAGS)
	IFS=$SAVEIFS
}

# TAGS="Another-tag Change Tag1 Tag2 Tag3 Test4 build-1 build-2 build-133 build-44"
# newlineToArray "$TAGS" ARRAY
# echo "${ARRAY[9]}"
# exit

get_git_build_number () {
	# CURRENT_TAG="Another-tag Change Tag1 Tag2 Tag3 Test4 build-1 build-2 build-133 build-44"
	CURRENT_TAG=`git tag --points-at HEAD`
	# CURRENT_TAG="custom tags"
	BUILD='build'
	if [[ "$CURRENT_TAG" == *"$BUILD"* ]]; then
		BUILD_REPS="${CURRENT_TAG//[^build]}"
		BUILD_COUNT=${#BUILD_REPS}
		if [ $BUILD_COUNT -gt 5 ]; then
			echo "error: More than one build tags are found"
			exit
		fi
		VALUE=${CURRENT_TAG#*-}
		local -n VAR=$1
		VAR=$VALUE
	else
		# TAGS="Another-tag Change Tag1 Tag2 Tag3 Test4 build-1 build-2 build-133 build-44"
		TAGS=`git tag`
		SAVEIFS=$IFS
		IFS=$'\n'
		TAGS=($TAGS)
		IFS=$SAVEIFS
		MAX=0
		for (( i=0; i<${#TAGS[@]}; i++ ))
		do
			if [[ "${TAGS[$i]}" == *"$BUILD"* ]]; then
				VALUE=${TAGS[$i]#*-}
				(($VALUE > MAX)) && MAX=$VALUE
			fi
		done
		local -n VAR=$1
		VAR=$(($MAX + 1))
	fi
}

get_git_build_number TAG
echo "$TAG"

