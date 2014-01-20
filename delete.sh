#!/bin/bash
#
# What happens when an unrelated unique constraint column is updated?
if [[ $1 ]]; then
	count=$1
else
	count=10000000
fi
echo "running $0 benchmark $count times"
while [ $count -gt 0 ]
do
	rand=`shuf -i 3-10 -n 1`
	echo "trying $0 $rand second run"
	psql -c "drop table if exists foo;"
	echo 'create unlogged table foo
	(
	unrelated int4 unique,
	merge text primary key,
	c text
	);' | psql
	pgbench -f benchdelete.sql -c 32 -T $rand -n -s 15000
	./foocount.sh
	if [[ $? != 0 ]]; then
		exit 1
	fi
	count=$(( $count - 1 ))
done
