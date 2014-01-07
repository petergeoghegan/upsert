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
echo "trying $0 $rand second run"
psql -c "drop table if exists foo;"
echo 'create unlogged table foo
(
a serial primary key,
merge int4 unique,
payload text
);' | psql
pgbench -f benchtwo.sql -c 8 -T $rand -n -s 150000
./foocount.sh
done
