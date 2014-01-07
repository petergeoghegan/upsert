#!/bin/bash
while true
do
rand=`shuf -i 10-20 -n 1`
echo "trying $0 $rand second run"
psql -c "drop table if exists foo;"
echo 'create unlogged table foo
(
merge int4 primary key,
b int4,
c text
);' | psql
pgbench -f benchsimple.sql -c 8 -T $rand -n -s 150000
./foocount.sh
done
