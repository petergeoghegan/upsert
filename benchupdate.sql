\set extent 10 * :scale
\setrandom rec 1 :extent
\setrandom irec 1 :extent
-- merge is a SERIAL column...we're testing how foo performs as a "plain
-- update" here -- inserts are impossible.
insert into foo(merge, b, c) values(:rec, :rec * random(), 'never') on conflict (merge) update set merge = :rec, c = 'update';
