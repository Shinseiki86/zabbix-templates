select count(*) as count
   /*c.owner, c.object_name, c.object_type,
   b.sid, b.serial#, b.status,
   a.locked_mode,
   b.osuser, b.machine,b.program,
   d.ctime/1000 as ctime*/
from v$locked_object a, v$session b, dba_objects c, v$lock d
where b.sid = a.session_id
    and a.object_id = c.object_id
    and d.sid = b.sid
    and (d.ctime/1000)>180
order by d.ctime desc;
exit;
