\set extent 10 * :scale
\setrandom rec 1 :extent
\setrandom irec 1 :extent
-- Note that we implicitly just use sequence value for PK column a (a is of type SERIAL):
insert into foo(merge, payload) values(:rec, 'insert') on conflict update set merge = :rec, payload = 'update';
