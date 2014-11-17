upsert test-cases
-----------------

Peter Geoghegan - pg@heroku.com

These test-cases are designed to perform perfunctory smoke-testing of the
upsert feature proposed for PostgreSQL.  Full details:

https://commitfest.postgresql.org/action/patch_view?id=1564

Good summary of current patch status:

https://wiki.postgresql.org/wiki/UPSERT

The tests also serve to give some rough sense of how different implementation
compare, in terms of their performance characteristics (implementation #1 and #2).

This is explained here:

https://wiki.postgresql.org/wiki/Value_locking

While not intended as formal benchmarks, currently there are enough differences
in the various approaches proposed that even a rough indication of performance
characteristics is useful.

Running the tests
-----------------

All tests are written in bash, with a dependency on pgbench, and PostgreSQL
with the patch applied. To run::

  ./main.sh
