#!/bin/bash

function get_member() {
	ASSET="${1}"
	whois -h whois.radb.net '!i'"${ASSET}"'' | while read LINE; do
		if echo "${LINE}" | grep -E ^AS; then
			MEMBERS="${LINE}"
		fi
	done
}

function levels() {
	MEMBERS="${1}"
	LEVEL="${2}"
	COUNT=$(echo "${MEMBERS}" | wc -w)
	COUNTER=0
	while [ $COUNTER -ne $COUNT ]; do
		for MEMBER in ${MEMBERS}; do
			if [[ "${MEMBER}" =~ "AS-" ]]; then
				EXP=$(get_member "${MEMBER}")
				echo "${MEMBER}|${EXP}"
			fi
			COUNTER=$((COUNTER + 1))
		done
	done
}

function pprint() {
	SOURCE="${1}"
	LEVEL="${2}"
	MEMBERS="${3}"
	echo "Level ${LEVEL} - ${SOURCE} - ${MEMBERS}"
}

function show_help() {
	echo "Usage: $0 <ASSET>"
	echo
	echo "ASSET: The Autonomous System Set to query."
	echo
	echo "Example:"
	echo "  $0 AS-EXAMPLE"
}

function main() {
	if [ -z "${1}" ]; then
		show_help
		exit 1
	fi

	LEVEL=1
	EXIT=0
	WATCHING=()
	ASSET=${1}

	echo "ASSET: ${ASSET}"
	MEMBERS=$(get_member ${ASSET})
	echo $MEMBERS
	pprint "${ASSET}" "${LEVEL}" "${MEMBERS}"

	while [ ${EXIT} -ne 1 ]; do
		LEVEL=$((LEVEL + 1))
		MEMBERS_TMP=()

		for EACH in ${MEMBERS}; do
			SAW=0
			if [[ "${EACH}" =~ "AS-" ]]; then
				for ITEM in ${WATCHING[@]}; do
					if [[ "${ITEM}" == "${EACH}" ]]; then
						SAW=1
					fi
				done

				if [[ ${SAW} -eq 0 ]]; then
					EXP=$(get_member "${EACH}")
					WATCHING+=(${EACH})
					MEMBERS_TMP+=(${EXP})
					if [[ "${EXP}" != "" ]]; then
						pprint "${EACH}" "${LEVEL}" "${EXP}"
					fi
				fi
			fi
		done

		echo "${MEMBERS_TMP[@]}"
		MEMBERS=$(echo "${MEMBERS_TMP[@]}")

		if [[ "${MEMBERS}" == "" ]]; then
			EXIT=1
		fi
	done
}

main "${1}"
