\set extent 10 * :scale
\setrandom rec 1 :extent
\setrandom irec 1 :extent
-- updating merge shouldn't hurt
insert into foo(merge, b, c) values(:rec, :rec * random(), 'foofoofoo') on conflict update set merge = :rec, c = :rec * random();
