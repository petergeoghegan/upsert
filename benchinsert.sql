\set extent 10 * :scale
\setrandom rec 1 :extent
\setrandom irec 1 :extent
-- merge is a SERIAL column...we're testing how foo performs as a plain insert
-- here -- no updates are possible. IGNORE would behave the same, and obviously
-- would never lock either.
insert into foo(b, c) values(:rec, 'foofoofoo') on conflict update set b = :rec, c = c;
