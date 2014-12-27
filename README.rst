upsert test-cases
-----------------

Peter Geoghegan - pg@heroku.com

These test-cases are designed to perform smoke-testing of the upsert feature
proposed for PostgreSQL.  Full details:

https://commitfest.postgresql.org/action/patch_view?id=1564

Good summary of current patch status:

https://wiki.postgresql.org/wiki/UPSERT

The tests also serve to give some rough sense of how different implementation
compare, in terms of their performance characteristics (implementation #1 and #2).

Details of each implementation are explained here:

https://wiki.postgresql.org/wiki/Value_locking

While not intended as formal benchmarks, currently there are enough differences
in the various approaches to "value locking" proposed that even a rough
indication of performance characteristics is useful.  Certain tests (not part
of the main test suite) give some indication of performance characteristics.

Running the tests
-----------------

All tests are written in bash, with a dependency on pgbench, and PostgreSQL
with the patch applied. To run::

  ./main.sh

More targeted stress-testing can also be performed, rather than running all
generic tests in an infinite loop using "main.sh".  For example::

  ./cardinality.sh

The stress test "torture.sh" is mostly of historic interest.  The tests
"insert.sh" and "update.sh", which are not called by "main.sh" can be used to
do basic benchmarking of each approach to value locking.  Alternatively, they
can be used to compare with a baseline of "comparable" regular inserts or
updates.
