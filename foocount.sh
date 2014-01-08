#!/bin/bash
#
# In all instances we're upserting into a table named foo with a column merge
# where conflicts are expected; when done, it should have no duplicate values

# don't trust index to indicate count of rows present/presence of spurious dups
dupcount=`psql -c "set enable_indexscan = off; set enable_indexonlyscan = off; select merge, count(*) from foo group by merge having count(*) > 1 order by 1;"`

red='\e[0;31m'
green='\e[0;32m'
NC='\e[0m' # No Color

psql -c "set enable_indexscan = off; set enable_indexonlyscan = off; select count(*) as total_count from foo;"

if [[ "$dupcount" == *"0 rows"* ]]
then
	echo -e "\n${green}Test passed:${NC}\n"
	echo "$dupcount"
	exit 0
else
	echo -e "\n${red}Test failed:${NC}\n"
	echo "$dupcount"
	exit 1
fi
