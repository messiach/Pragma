select * from v$temp_space_header;
select * from v$tempfile;
select * from v$temp_extent_map;
select * from v$tempseg_usage;
select * from v$tempstat;

select * from dba_temp_files;

SELECT SUBSTR (df.NAME, 1, 100) file_name, df.bytes / 1024 / 1024 allocated_mb,
((df.bytes / 1024 / 1024) - NVL (SUM (dfs.bytes) / 1024 / 1024, 0))
used_mb,
NVL (SUM (dfs.bytes) / 1024 / 1024, 0) free_space_mb
FROM v$tempfile df, dba_free_space dfs
WHERE df.file# = dfs.file_id(+)
group by SUBSTR (df.NAME, 1, 100), df.bytes / 1024 / 1024
ORDER BY file_name;

select count(*) from epmasstored;

 select d.tablespace_name, d.file_id, d.file_name, d.bytes allocated, nvl(f.bytes,0) free
    from (select tablespace_name, file_id, file_name, sum(bytes) bytes from dba_temp_files
       group by tablespace_name, file_id, file_name) d,
      (select tablespace_name, file_id, sum(bytes) bytes from dba_free_space
     group by tablespace_name, file_id) f
    where d.tablespace_name = f.tablespace_name(+)
  and d.file_id = f.file_id(+)
  order by tablespace_name, file_id;
  
select * from v$sort_segment;
select * from v$sort_usage;
  

select * from v$session where username='STAGING';