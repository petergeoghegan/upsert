#!/bin/bash
#
# Note that "torture" is no longer called by main.sh
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
	echo "trying $0 $rand second run"
	psql -c "drop table if exists torture;"
	echo 'create unlogged table torture
	(
	a int4 primary key,
	b int4 unique,
	c int4 unique,
	d int4 unique,
	e int4 unique,
	f int4 unique,
	g int4 unique,
	merge int4 unique,
	payload text
	);' | psql
	psql -c "create index ddd on torture(payload);"
	pgbench -f benchtorture.sql -j 4 -c 8 -T $rand -n -s 1
	#./foocount.sh
	if [[ $? != 0 ]]; then
		exit 1
	fi
	count=$(( $count - 1 ))
done
