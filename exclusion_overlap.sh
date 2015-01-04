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
	echo 'CREATE TABLE foo(
	during tsrange,
	EXCLUDE USING gist (during WITH &&)
	);' | psql

	pgbench -f benchexclusion_overlap.sql -j 4 -c 64 -t 1000 -n -s 1
	if [[ $? != 0 ]]; then
		exit 1
	fi
	count=$(( $count - 1 ))
done
