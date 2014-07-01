#!/bin/bash
#
# The point of this benchmark is in large part to get a sense of the
# performance overhead of unnecessarily value locking a serial PK, where
# presumably the sequential serial values represent a worse case for value
# locking.  In the btree locking patch, we lock primary key last and release it
# first, partly in anticipation of this problem.
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
	merge text unique,
	payload text
	);' | psql
	pgbench -f benchtwo.sql -j 4 -c 8 -T $rand -n -s 1
	./foocount.sh
	psql -c "select bt_parent_index_verify('foo_pkey');"
	psql -c "select bt_leftright_verify('foo_pkey');"
	if [[ $? != 0 ]]; then
		exit 1
	fi
	count=$(( $count - 1 ))
done
