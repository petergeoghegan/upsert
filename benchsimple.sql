\set extent 10 * :scale
\setrandom rec 1 :extent
\setrandom irec 1 :extent
--set transaction_isolation = 'serializable';
with rej as(insert into foo(a, b, c) values(:rec, :rec * random(), 'fd') on duplicate key lock for update returning rejects *) update foo set c = rej.c from rej where foo.a = rej.a;
