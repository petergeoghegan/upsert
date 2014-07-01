\set extent 1 * :scale
\setrandom rec 1 :extent
\setrandom unrelreci 1 10000
with rej as(insert into foo(merge, unrelated, c) values(:rec, :unrelreci, 'insert') on conflict select * for update) delete from foo using rej where foo.merge = rej.merge;
