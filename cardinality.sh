#!/bin/bash
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
	merge int4 primary key,
	b text,
	c text
	);' | psql
	pgbench -f benchcardinality.sql -j 4 -c 4 -T $rand -n -s 15000
	./foocount.sh
	if [[ $? != 0 ]]; then
		exit 1
	fi
	count=$(( $count - 1 ))
done
