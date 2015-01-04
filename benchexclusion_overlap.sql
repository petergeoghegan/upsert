\set extent 10 * :scale
\setrandom rec 1 :extent
\setrandom irec 1 :extent
--with start as (select now()::timestamp - interval '1 day' * random() s ), d as (delete from foo where random() < 0.1 and during && tsrange((select s from start), (select s from start) + interval '5 minutes') returning *) insert into foo(during) select tsrange((select s from start), (select s from start) + interval '1 hour'* random()) on conflict ignore;
with start as (select now()::timestamp - interval '1 day' * random() s ) insert into foo(during) select tsrange((select s from start), (select s from start) + interval '1 hour'* random()) on conflict ignore;
