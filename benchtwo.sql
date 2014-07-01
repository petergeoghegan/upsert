\set extent 10 * :scale
\setrandom rec 1 :extent
\setrandom irec 1 :extent
-- Note that we implicitly just use sequence value for PK column a (a is of type SERIAL):
with rej as(insert into foo(merge, payload) values(:rec, 'insert') on conflict select * for update) update foo set payload = 'update' from rej where foo.merge = rej.merge;
