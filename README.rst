upsert test-cases
-----------------

Peter Geoghegan - pg@heroku.com

These test-cases are designed to perform perfunctory smoke-testing of the
upsert feature proposed for PostgreSQL 9.4.  Full details:

https://commitfest.postgresql.org/action/patch_view?id=1201

The tests also serve to give some rough sense of how different implementation
compare, in terms of their performance characteristics.  While not intended as
formal benchmarks, currently there are enough differences in the various
approaches proposed that even without long-running benchmarks, and the
variability added by noise, and even the variability added by the fact that
upsert is very much a multi-faceted feature whose constituent parts can
interact in very counter-intuitive ways, they are expected to be useful.  A
rough indication of performance characteristics is useful at this juncture.

Running the tests
-----------------

All tests are written in bash, with a dependency on pgbench, and PostgreSQL
with the INSERT...ON DUPLICATE KEY LOCK FOR UPDATE patch applied. To run::

  ./main.sh
