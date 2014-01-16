\set extent 10 * :scale
\setrandom reca 1 :extent
\setrandom recb 1 :extent
\setrandom recc 1 :extent
\setrandom recd 1 :extent
\setrandom rece 1 :extent
\setrandom recf 1 :extent
\setrandom recg 1 :extent
\setrandom recmerge 1 :extent
with rej as(insert into foo(a, b, c, d, e, f, g, merge, payload) values (:reca, :recb, :recc, :recd, :rece, :recf, :recg, :recmerge, 'insert'), (:recb, :recf, :rece, :recg, :rece, :recb, :reca, :recmerge, 'insert') on duplicate key lock for update returning rejects ctid, *) update foo set payload = (random() * 5)::text from rej where foo.ctid = rej.ctid;
