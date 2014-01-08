#!/bin/bash
#
# Test upsert as a replacement for insert...no update part, for comparison
# against raw insert for performance
#
# This benchmark appears to indicate that even with heavyweight page locks, the
# performance of these two cases is remarkably similar
if [[ $1 ]]; then
	count=$1
else
	count=10000000
fi

bold=`tput bold`
normal=`tput sgr0`
NC='\e[0m' # No Color

echo "running $0 benchmark $count times"
echo "${bold}Note that a SERIAL PK is used here, to maximize lock contention ${normal}"
while [ $count -gt 0 ]
do
	echo "running $0 benchmark"
	seconds=60
	echo "trying $seconds second run ${bold}(new infrastructure, extended hwlocking)${normal}"
	psql -c "drop table if exists foo;"
	echo 'create unlogged table foo
	(
	merge serial primary key,
	b int4,
	c text
	);' | psql
	pgbench -f benchinsert.sql -c 8 -T $seconds -n -s 150000
	if [[ $? != 0 ]]; then
		exit 1
	fi
	echo "trying $seconds second run ${bold}(traditional inserts, equivalent to master)${normal}"
	psql -c "drop table if exists foo;"
	echo 'create unlogged table foo
	(
	merge serial primary key,
	b int4,
	c text
	);' | psql
	pgbench -f benchplaininsert.sql -c 8 -T $seconds -n -s 150000
	count=$(( $count - 1 ))
	echo -e "\n\n"
done
