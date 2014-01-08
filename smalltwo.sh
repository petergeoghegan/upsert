#!/bin/bash
#
# The point of this benchmark is in large part to get a sense of the
# performance overhead of unnecessarily value locking a serial PK, where
# presumably the sequential serial values represent a worse case for value
# locking.  In the btree locking patch, we lock primary key last and release it
# first, partly in anticipation of this problem.
#
# This variant of two benchmark tries to stress contention harder with a
# smaller scale factor (though ordinary lock contention comes to dominate).

if [[ $1 ]]; then
	count=$1
else
	count=10000000
fi
echo "running $0 benchmark $count times"
while [ $count -gt 0 ]
do
	rand=`shuf -i 10-20 -n 1`
	echo "trying $0 $rand second run"
	psql -c "drop table if exists foo;"
	echo 'create unlogged table foo
	(
	a serial primary key,
	merge int4 unique,
	payload text
	);' | psql
	pgbench -f benchtwo.sql -c 8 -T $rand -n -s 15
	./foocount.sh
	count=$(( $count - 1 ))
done
