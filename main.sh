#!/bin/bash
#
# Client count, scale, and duration are not configurable because they're
# generally thought to be essential to the nature of the thing being tested.

# runs per benchmark
runs=3
while [ 1 ]
do
	for f in simple.sh two.sh smalltwo.sh text.sh cardinality.sh updatekey.sh
	do
		./$f $runs
		if [[ $? != 0 ]]; then
			exit 1
		fi
	done
done

# Other interesting tests not run here:
# torture.sh
# "Vs vanilla insert/update" tests
