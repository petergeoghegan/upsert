#!/bin/bash
#
# benchsimple variant. Merge column is text here, implying that comparisons are
# considerably more expensive, as well as that btree index tuples are of
# variable size, which could conceivably be broken independently of other
# things.
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
	echo 'create table foo
	(
	merge text primary key,
	b int4,
	c text
	);' | psql
	pgbench -f benchsimple.sql -j 4 -c 8 -T $rand -n -s 150000
	./foocount.sh
	if [[ $? != 0 ]]; then
		exit 1
	fi
	count=$(( $count - 1 ))
done
