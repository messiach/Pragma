-- verify all completed work items were mapped to an audit
select (select count(*) from workitem where status='COMPLETED') as completed_wi, (select count(*) from chtoauditlink) as links from dual;

-- verify all audits were mapped to only 1 work item
select ida3b5,count(ida3b5) as occurrences from chtoauditlink group by ida3b5 having (count(ida3b5) > 1);

-- verify if there are any dangling audits that were not mapped
select (select count(*) from chtoauditlink) as links, (select count(*) from wfvotingeventaudit) as audits from dual;

-- get a count of how many overlapping audits there are
select ((select count(*) from wfvotingeventaudit) - (select count(*) from chtoauditlink)) as overlap from dual;

-- get the rows of the overlapping entries
select * from wfvotingeventaudit left outer join chtoauditlink on wfvotingeventaudit.ida2a2=chtoauditlink.ida3b5 where chtoauditlink.ida2a2 is null;

-- get the count of how much of the overlap is due to a missing process
select count(*) from (select processkey from wfvotingeventaudit left outer join chtoauditlink on wfvotingeventaudit.ida2a2=chtoauditlink.ida3b5 where chtoauditlink.ida2a2 is null) where processkey not in (select wtkey from wfprocess);

-- healing statement to remove audits that no longer have processes
select count(*) from wfvotingeventaudit a0, (select * from (select processkey from wfvotingeventaudit left outer join chtoauditlink on wfvotingeventaudit.ida2a2=chtoauditlink.ida3b5 where chtoauditlink.ida2a2 is null) where processkey not in (select wtkey from wfprocess)) a1 where a0.processkey=a1.processkey;
select * from wfvotingeventaudit a0, (select * from (select processkey from wfvotingeventaudit left outer join chtoauditlink on wfvotingeventaudit.ida2a2=chtoauditlink.ida3b5 where chtoauditlink.ida2a2 is null) where processkey not in (select wtkey from wfprocess)) a1 where a0.processkey=a1.processkey;
delete from wfvotingeventaudit where ida2a2 in (select ida2a2 from wfvotingeventaudit a0, (select * from (select processkey from wfvotingeventaudit left outer join chtoauditlink on wfvotingeventaudit.ida2a2=chtoauditlink.ida3b5 where chtoauditlink.ida2a2 is null) where processkey not in (select wtkey from wfprocess)) a1 where a0.processkey=a1.processkey);

-- get the count of how much of the overlap is due to a missing activity
select count(*) from (select activitykey from wfvotingeventaudit left outer join chtoauditlink on wfvotingeventaudit.ida2a2=chtoauditlink.ida3b5 where chtoauditlink.ida2a2 is null) where activitykey not in (select wtkey from wfassignedactivity);

-- healing statement to remove audits that no longer have activities
select count(*) from wfvotingeventaudit a0, (select * from (select activitykey from wfvotingeventaudit left outer join chtoauditlink on wfvotingeventaudit.ida2a2=chtoauditlink.ida3b5 where chtoauditlink.ida2a2 is null) where activitykey not in (select wtkey from wfassignedactivity)) a1 where a0.activitykey=a1.activitykey;

-- get the count of how much of the overlap is due to a naming conflict on the wfprocess (names don't match)
select count(*) from (select processname from wfvotingeventaudit left outer join chtoauditlink on wfvotingeventaudit.ida2a2=chtoauditlink.ida3b5 where chtoauditlink.ida2a2 is null) where processname not in (select name from wfprocess);

-- get the count of how much of the overlap is due to naming conflict on the wfassignedactivity (names don't match)
select count(*) from (select activityname from wfvotingeventaudit left outer join chtoauditlink on wfvotingeventaudit.ida2a2=chtoauditlink.ida3b5 where chtoauditlink.ida2a2 is null) where activityname not in (select name from wfassignedactivity);
select * from (select activityname from wfvotingeventaudit left outer join chtoauditlink on wfvotingeventaudit.ida2a2=chtoauditlink.ida3b5 where chtoauditlink.ida2a2 is null) where activityname not in (select name from wfassignedactivity);

-- get the count of duplicate audits in the system (having the same 4 fields and timestamp)
select * from (select activityname, processname, activitykey, processkey, timestamp from wfvotingeventaudit group by activityname, processname, activitykey, processkey, timestamp having count(*) > 1); 


-- get the number of workitems with a context - result 288
select count(*) from WorkItem where context is not null;

-- get the number of workitems without a context - result 47401
select count(*) from WorkItem where context is null;