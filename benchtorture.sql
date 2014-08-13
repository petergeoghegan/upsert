\set extent 10 * :scale
\setrandom reca 1 :extent
\setrandom recb 1 :extent
\setrandom recc 1 :extent
\setrandom recd 1 :extent
\setrandom rece 1 :extent
\setrandom recf 1 :extent
\setrandom recg 1 :extent
\setrandom recmerge 1 :extent
\setrandom sreca 1 :extent
\setrandom srecb 1 :extent
\setrandom srecc 1 :extent
\setrandom srecd 1 :extent
\setrandom srece 1 :extent
\setrandom srecf 1 :extent
\setrandom srecg 1 :extent
\setrandom srecmerge 1 :extent
insert into foo(a, b, c, d, e, f, g, merge, payload) values (:reca, :recb, :recc, :recd, :rece, :recf, :recg, :recmerge, 'insert'), (:sreca, :srecb, :srecc, :srecd, :srece, :srecf, :srecg, :srecmerge, 'insert') on conflict update set payload = (random() * 5);
