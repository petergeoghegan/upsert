\set extent 10 * :scale
\setrandom rec 1 :extent
\setrandom irec 1 :extent
-- There is no use of new infrastructure here...just for comparative purposes
insert into foo(b, c) values(:rec, 'foofoofoo');
