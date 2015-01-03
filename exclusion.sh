#!/bin/bash
if [[ $1 ]]; then
	count=$1
else
	count=10000000
fi
echo "running $0 benchmark $count times"
while [ $count -gt 0 ]
do
	echo "trying $0 100000 transaction, 8 client run"
	psql -c "drop table if exists foo;"
	psql -c "create extension if not exists btree_gist;"
	echo 'CREATE TABLE foo (
	  excl_key int4,
	  val text,
	  EXCLUDE USING gist (excl_key WITH =)
	);' | psql
	pgbench -f benchexclusion.sql -j 4 -c 8 -t 100000 -n -s 10
	if [[ $? != 0 ]]; then
		exit 1
	fi
	count=$(( $count - 1 ))
done
