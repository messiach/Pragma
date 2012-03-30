-- epm docs
select count(*) from epmdocument;          -- count = 715,730  --> Windchill EPMDocument objects (TBM)

-- epm build structure
select count(*) from epmbuildhistory;      -- count = 80,337   --> Windchill EPMDocument->Part Relationship objects [ACTIVE link, prev iteration] (TBM)
select count(*) from epmbuildrule;         -- count = 24,618   --> Windchill EPMDocument->Part Relationship objects [ACTIVE link, latest iteration] (TBM)
select count(*) from epmdescribelink;      -- count = 132,942  --> Windchill EPMDocument->Part Relationship objects [PASSIVE link, content only] (TBM)
select count(*) from epmmemberlink;        -- count = 6,991,967 --> Windchill EPMDocument->EPMDocument Relationship objects [Links an EPMDocument iteration as 'usedBy' and an EPMDocument master as 'uses'] (TBM)
select count(*) from epmvariantlink;       -- count = 171,321   --> Windchill EPMDocument->Generic EPMDocument Relationship objects [Links an EPMDocument iteration with the 'generic' master from the family table] (TBM)
select count(*) from epmreferencelink;     -- count = 3,324,721 --> Windchill EPMDocument->DocumentMaster Relationship objects [Links an EPMDocument iteration with another EPMDocument, usually a Drawing from CAD software, or to a WTDocument... ] (TBM)

select count(*) from epmbuildattribute;    -- count = 0
select count(*) from epmderivedrephistory; -- count = 0
select count(*) from epmderivedreprule;    -- count = 0

-- workspace checkpoints (baselines)
-- ** These are baselines of the current iteration of epm docs in the workspace
-- ** Right now this always equals the number of workspaces, so there is one per workspace
-- *** WILL THESE NEED TO BE MIGRATED AT ALL??
-- **** YES - TBM - epmcheckpoint is a field on the epmworkspace object and is required.
select count(*) from epmcheckpoint;        -- count = 1,654
select count(*) from epmcheckpointmaster;  -- count = 809,860

-- cad namespaces
-- ** These are used to prevent naming conflicts when a CAD document is shared between PDM/PJL.
-- ** Names and references to the master of each CAD document are stored.
-- ** Later, if the object is shared to a project or checked out to pdm, the shared container is stored as well.
select count(*) from epmcadnamespace;      -- count = 208,115

-- workspaces
select count(*) from epmworkspace;         -- count = 1,654   --> PDMLink user workspaces

-- config specs aggregate
-- ** These objects are assigned the various config specs available for an EPMDocument.
--    The objects are then assigned directly to a workspace, so the workspace knows which 
--    type of config specs are available and which config spec is active.
-- **** WILL NEED TO LOOK INTO OTHER CONFIG SPECS THAT THS OBJECT RELIES ON - MAY NEED TO EXTRACT AS WELL!!
select count(*) from epmdocconfigspec;     -- count = 716,438

-- as stored config
-- ** represents the configuration itself and the members of those configs
select count(*) from epmasstoredconfig;    -- count = 86,398
select count(*) from epmasstoredmember;    -- count = 15,394,851

-- authoring apps
select count(*) from epmauthoringappversion;   -- count = 97

-- family tables (master not extracted as it is most likely created with each distinct epmsepfamilytable creation, subsequent iterations are added to the master)
-- 1) The 'epmfamilytablecell' represents the actual cell in the row/column of the family table as it belongs to a specific instance in the family table.
-- ** The 'epmfamilytablecell' points to an 'epmcontainedin' object which references both an epmdocument and the epmsepfamilytable it belongs to. 
-- *** In this way, the cell can be referenced back to the specific row instance (ie, the epmdocument in Windchill).
select count(*) from epmsepfamilytable;       -- count = 13,218
select count(*) from epmfamilytablecell;      -- count = 2,494,600
select count(*) from epmfamilytablecelldep;   -- count = 27,465
select count(*) from epmfamilytablemember;    -- count = 12,465

-- family table features
--  1) The 'epmfeaturedefinition' provides the definition of the feature (name, type, valueType, internalId) and has a foreign key link to a epmfeaturedefinitioncontainer, which is actually an epmsepfamilytablemaster.
--  2) The 'epmfamilytablefeature' relates an 'epmfeaturedefinition' directly to an epmsepfamilytable and provides the title for the feature. The 'epmfamilytablefeature' is also known as an 'epmfamilytablecolumn' because in pro/e it is a column in the family table. An 'epmfamilytablecolumn' has the name, title, columnType, attribute, and familytablereference attributes.
--  3) The 'epmfeaturevalue' relates the value for an epmfamilytablefeature directly to a specific 'epmfeaturecontainer', which is actually an epmdocument. An 'epmfeaturecontainer' can provide and set a map of features.
select count(*) from epmfamilytablefeature;   -- count = 39,629   --> CAD Authoring App feature defined on family table generic cad model - relates a feature definition directly to a family table (not the master) and provides the title for the feature
select count(*) from epmfeaturedefinition;    -- count = 5,847    --> CAD Authoring App feature defined on family table generic cad model (this is the type of feature) - relates directly to the master family table for the family table tree and has an internal id
select count(*) from epmfeaturevalue;         -- count = 390,187  --> CAD Authoring App feature as turned on or off - value will only ever be true/false (1/0 in 'numbervalue' column) - relates directly to the epmdocument only

-- family table attributes
--  1) The 'epmfamilytableattribute' are designated parameters that are mapped to real attributes (IBAs in fact) on the Windchill model of the EPMDocument.
-- ** Anything in this table was mapped to an IBA on EPMDocument type in Windchill.
-- ** Upon checkin from PRO/E, the designated parameter value is copied to the mapped Windchill IBA.
select count(*) from epmfamilytableattribute; -- count = 6,609

-- family table parameters
-- ** This is an EXACT replica of the object model for family table features - only difference is in the naming scheme (parameter instead of feature).
-- *** ALSO...the 'epmparametervalue' uses both value fields and is not a simple on/off number based value - can be a number or string depending on the definition of the parameter.
-- *** ALSO...the 'epmparametermap' 
select count(*) from epmfamilytableparameter; -- count = 40,297
select count(*) from epmparameterdefinition;  -- count = 6,676
select count(*) from epmparametervalue;       -- count = 1,307,660

-- ??
select count(*) from epmparametermap;         -- count = 0

-- family table relationships
-- 1) The 'epmcontainedin' object to object link provides a link between a 'containedby', ie the family table, and a'contains', ie the epmdocument contained in that family table. 
--    In Windchill, these are two separate business objects, but the 'epmcontainedin' link exposes the relationship in the actual CAD file.
select count(*) from epmcontainedin;       -- count = 248,395




-- occurrences
select count(*) from epmoccurrencetable;      -- count = 189,767
select count(*) from epmusesoccurrence;       -- count = 140

-- wtparts
select count(*) from wtpart;            -- count = 90,766  --> Windchill WTPart objects (TBM)

