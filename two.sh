#!/bin/bash
#
# The point of this benchmark is in large part to get a sense of the
# performance overhead of unnecessarily value locking a serial PK, where
# presumably the sequential serial values represent a worse case for value
# locking.  In the btree locking patch, we lock primary key last and release it
# first, partly in anticipation of this problem.
while true
do
rand=`shuf -i 10-20 -n 1`
echo "trying $rand second run"
psql -c "drop table if exists foo;"
echo 'create unlogged table foo
(
a serial primary key,
uniqueval int4 unique,
payload text
);' | psql
pgbench -f benchtwo.sql -c 8 -T $rand -n -s 150000
# don't trust index to indicate count of rows present/presence of spurious dups
psql -c "set enable_indexscan = off; set enable_indexonlyscan = off; select a, count(*) from foo group by a having count(*) > 1 order by 1;"
psql -c "set enable_indexscan = off; set enable_indexonlyscan = off; select count(*) as total_count from foo;"
done
