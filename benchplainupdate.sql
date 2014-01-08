\set extent 10 * :scale
\setrandom rec 1 :extent
-- There is no use of new infrastructure here...just for comparative purposes
update foo set c = 'update' where merge = :rec;
