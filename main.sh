#!/bin/bash
#
# Client count, scale, and duration are not configurable because they're
# generally thought to be essential to the nature of the thing being tested.

# runs per benchmark
runs=3
for f in simple.sh insert.sh update.sh two.sh smalltwo.sh text.sh
do
	./$f $runs
	if [[ $? != 0 ]]; then
		exit 1
	fi
done
