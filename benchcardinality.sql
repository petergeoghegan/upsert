\set extent 10 * :scale
\setrandom rec 1 :extent
\setrandom irec 1 :extent
insert into foo(merge, b, c) values (:rec * random(), 'foo', 'bar'), (:rec * random(), 'bash', 'biff'), (:rec * random(), 'boff', 'nosh') on conflict(merge) update set b = '|' || target.b, c = 'ex: ' || excluded.c;
