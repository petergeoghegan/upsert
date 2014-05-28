\set extent 10 * :scale
\setrandom reca 1 :extent
insert into foo(merge, payload) values (:reca, 'insert');
