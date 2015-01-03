\set extent 10 * :scale
\setrandom rec 1 :extent
\setrandom irec 1 :extent
insert into foo(excl_key, val) values(:rec, 'Fiz') on conflict ignore;
