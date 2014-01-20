\set extent 1 * :scale
\setrandom rec 1 :extent
\setrandom unrelreci 1 100000
\setrandom unrelrecu 1 100000
with rej as(insert into foo(merge, unrelated, c) values(:rec, :unrelreci, 'insert') on duplicate key lock for update returning rejects *) delete from foo using rej where foo.merge = rej.merge;
