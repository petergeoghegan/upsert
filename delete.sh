#!/bin/bash
#
# What happens when an unrelated unique constraint column is updated?
if [[ $1 ]]; then
	count=$1
else
	count=10000000
fi
finished=0
echo "running $0 benchmark $count times"
while [ $count -gt 0 ]
do
	rand=`shuf -i 1000-3000 -n 1`
	echo "trying $0 $rand transaction run"
	date
	psql -c "drop table if exists foo;"
	echo 'create unlogged table foo
	(
	unrelated int4 unique,
	merge text primary key,
	c text
	);' | psql
	pgbench -f benchdelete.sql -j 4 -c 64 -t $rand -n -s 15000
	./foocount.sh
	if [[ $? != 0 ]]; then
		exit 1
	fi
	count=$(( $count - 1 ))
	finished=$(( $finished + 1 ))
	echo "finished iteration $finished"
done
