#!/bin/bash
#
# In all instances we're upserting into a table named foo with a column merge
# where conflicts are expected; when done, it should have no duplicate values

# don't trust index to indicate count of rows present/presence of spurious dups
psql -c "set enable_indexscan = off; set enable_indexonlyscan = off; select merge, count(*) from foo group by merge having count(*) > 1 order by 1;"
psql -c "set enable_indexscan = off; set enable_indexonlyscan = off; select count(*) as total_count from foo;"
