#!/bin/bash
#
# Test upsert as a replacement for update...range of possible values to upsert
# on is so large that insert will almost never occur.
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

seconds=60
# number of tuples to update is actually $tuples * 10
tuples=1000000
pretuples=100000

echo "running $0 benchmark $count times"
echo "Test upsert as a replacement for update...no insert part, for comparison against raw update performance"
echo "${bold}UPSERT with no inserts, only updates, vs. equivalent updates${normal}"
while [ $count -gt 0 ]
do
	echo "running $0 benchmark"
	echo "trying $seconds second run ${bold}(new infrastructure, extended hwlocking)${normal}"
	psql -c "drop table if exists foo;"
	echo 'create unlogged table foo
	(
	merge serial primary key,
	b int4,
	c text
	);' | psql
	echo "${bold}pre-inserting tuples to update${normal}"
	pgbench -f benchplaininsert.sql -j 4 -c 10 -t $pretuples -n -s $tuples > /dev/null
	psql -c "checkpoint;"
	pgbench -f benchupdate.sql -c 8 -T $seconds -n -s $tuples
	echo "trying $seconds second run ${bold}(traditional updates, equivalent to master)${normal}"
	psql -c "drop table if exists foo;"
	echo 'create unlogged table foo
	(
	merge serial primary key,
	b int4,
	c text
	);' | psql
	echo "${bold}pre-inserting tuples to update${normal}"
	pgbench -f benchplaininsert.sql -c 10 -t $pretuples -n -s $tuples > /dev/null
	psql -c "checkpoint;"
	pgbench -f benchplainupdate.sql -c 8 -T $seconds -n -s $tuples
	count=$(( $count - 1 ))
	echo -e "\n\n"
done
