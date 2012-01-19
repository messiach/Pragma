-- verify all completed work items were mapped to an audit
select (select count(*) from workitem where status='COMPLETED') as completed_wi, (select count(*) from chtoauditlink) as links from dual;

-- verify all audits were mapped to only 1 work item
select ida3b5,count(ida3b5) as occurrences from chtoauditlink group by ida3b5 having (count(ida3b5) > 1);

-- verify if there are any dangling audits that were not mapped
select (select count(*) from chtoauditlink) as links, (select count(*) from wfvotingeventaudit) as audits from dual;

-- get a count of how many overlapping audits there are
select ((select count(*) from wfvotingeventaudit) - (select count(*) from chtoauditlink)) as overlap from dual;

-- get the rows of the overlapping entries
select processkey from wfvotingeventaudit left outer join chtoauditlink on wfvotingeventaudit.ida2a2=chtoauditlink.ida3b5 where chtoauditlink.ida2a2 is null;

-- get the count of how much of the overlap is due to a missing process
select count(*) from (select processkey from wfvotingeventaudit left outer join chtoauditlink on wfvotingeventaudit.ida2a2=chtoauditlink.ida3b5 where chtoauditlink.ida2a2 is null) where processkey not in (select wtkey from wfprocess);
