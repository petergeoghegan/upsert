\set extent 10 * :scale
\setrandom rec 1 :extent
\setrandom irec 1 :extent
insert into foo(merge, b, origin) values (:extent * random(), :extent * random(), 'insert (with update to key)') on conflict(merge) update set merge = :extent * random(), origin = 'update, orig key ' || excluded.merge where (500 * random() < 1);
insert into foo(merge, b, origin) values (:extent * random(), :extent * random(), 'insert (with update to unindexed column)') on conflict(merge) update set b = :extent * random(), origin = 'update (unindexed), orig key ' || excluded.merge where (50 * random() < 1);
