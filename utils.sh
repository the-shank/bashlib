#!/bin/bash

# ABOUT:
# Collection of util functions

# returns the name of the current script, without the extension.
function scriptname() {
	local filename="$(basename \"$0\")"
	echo "${filename%.*}"
}

# runs self with changed niceness
renice_self() {
	local target_niceness=10
	local pid=$BASHPID
	# echo "my pid is ${pid}"

	local niceness=$(ps -x -o pid,ni | rg ${pid} | awk '{print $2}')
	# echo "my niceness is ${niceness}"

	if ! [ ${niceness} -eq ${target_niceness} ]; then
		renice +${target_niceness} -p ${pid} >/dev/null
		local new_niceness=$(ps -x -o pid,ni | rg ${pid} | awk '{print $2}')
		# echo "my (new) niceness is ${new_niceness}"
	fi

	echo ">> running with niceness 10"
}

# 1 -> 01
# 10 -> 10
function padded() {
	local i=$1
	if [ "$i" -lt 10 ]; then
		echo "0${i}"
	else
		echo "${i}"
	fi
}

# echo to stderr instead of stdout
function echoerr() {
	echo "$@" 1>&2
}
