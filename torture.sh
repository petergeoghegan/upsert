#!/bin/bash
#
if [[ $1 ]]; then
	count=$1
else
	count=10000000
fi
echo "running $0 benchmark $count times"
while [ $count -gt 0 ]
do
	rand=`shuf -i 60-120 -n 1`
	clients=`shuf -i 30-120 -n 1`
	echo "trying $0 $rand second run, $clients clients"
	psql -c "truncate foo;"
	echo 'create table foo
	(
	merge int4 primary key,
	payload text
	);' | psql
	pgbench -f benchtorture.sql -c $clients -T $rand -n -s 10000
	./foocount.sh
	if [[ $? != 0 ]]; then
		exit 1
	fi
	count=$(( $count - 1 ))
done
