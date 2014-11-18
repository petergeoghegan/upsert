#!/bin/bash
if [[ $1 ]]; then
	count=$1
else
	count=10000000
fi
echo "running $0 benchmark $count times"
while [ $count -gt 0 ]
do
	rand=`shuf -i 120-300 -n 1`
	echo "trying $0 $rand second run"
	psql -c "drop table if exists foo;"
	echo 'create table foo
	(
	merge int4 primary key,
	b int4,
	origin text
	);' | psql
	# Update key, but only apply update occasionally
	pgbench -f benchupdatekey.sql -j 4 -c 16 -T $rand -n -s 15000
	./foocount.sh
	if [[ $? != 0 ]]; then
		exit 1
	fi
	count=$(( $count - 1 ))
done
