#!/bin/bash
while true
do
rand=`shuf -i 10-20 -n 1`
echo "trying $rand second run"
psql -c "drop table if exists foo;"
echo 'create unlogged table foo
(
a int4 primary key,
b int4,
c text
);' | psql
pgbench -f benchsimple.sql -c 8 -T $rand -n -s 150000
# don't trust index to indicate count of rows present/presence of spurious dups
psql -c "set enable_indexscan = off; set enable_indexonlyscan = off; select a, count(*) from foo group by a having count(*) > 1 order by 1;"
psql -c "set enable_indexscan = off; set enable_indexonlyscan = off; select count(*) as total_count from foo;"
done
