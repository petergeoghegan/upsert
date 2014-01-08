\set extent 10 * :scale
\setrandom rec 1 :extent
\setrandom irec 1 :extent
-- merge is a SERIAL column...we're testing how foo performs as a "plain
-- update" here -- inserts are impossible.
with rej as(insert into foo(merge, b, c) values(:rec, :rec * random(), 'never') on duplicate key lock for update returning rejects *) update foo set c = 'update' from rej where foo.merge = rej.merge;
