\set extent 10 * :scale
\setrandom rec 1 :extent
\setrandom irec 1 :extent
-- note that we just use serial value for PK a:
with rej as(insert into foo(merge, payload) values(:rec, 'insert') on duplicate key lock for update returning rejects *) update foo set payload = 'update' from rej where foo.merge = rej.merge;
