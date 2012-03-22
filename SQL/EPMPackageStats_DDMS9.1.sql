-- epm docs
select count(*) from epmdocument;          -- count = 715,730  --> Windchill EPMDocument objects (TBM)

-- epm build structure
select count(*) from epmbuildhistory;      -- count = 80,337   --> Windchill EPMDocument->Part Relationship objects [ACTIVE link, prev iteration] (TBM)
select count(*) from epmbuildrule;         -- count = 24,618   --> Windchill EPMDocument->Part Relationship objects [ACTIVE link, latest iteration] (TBM)
select count(*) from epmdescribelink;      -- count = 132,942  --> Windchill EPMDocument->Part Relationship objects [PASSIVE link, content only] (TBM)
select count(*) from epmmemberlink;        -- count = 6,991,967
select count(*) from epmvariantlink;       -- count = 171,321
select count(*) from epmreferencelink;     -- count = 3,324,721
select count(*) from epmcontainedin;       -- count = 248,395
select count(*) from epmbuildattribute;    -- count = 0
select count(*) from epmderivedrephistory; -- count = 0
select count(*) from epmderivedreprule;    -- count = 0

-- ??
select count(*) from epmcadnamespace;      -- count = 208,115
select count(*) from epmcheckpoint;        -- count = 1,654
select count(*) from epmcheckpointmaster;  -- count = 809,860
select count(*) from epmworkspace;         -- count = 1,654

-- config specs
select count(*) from epmdocconfigspec;     -- count = 716,438

-- as stored config
select count(*) from epmasstoredconfig;    -- count = 86,398
select count(*) from epmasstoredmember;    -- count = 15,394,851

-- authoring apps
select count(*) from epmauthoringappversion;   -- count = 97

-- family tables
select count(*) from epmsepfamilytable;       -- count = 13,218
select count(*) from epmfamilytablefeature;   -- count = 39,629
select count(*) from epmfeaturedefinition;    -- count = 5,847
select count(*) from epmfeaturevalue;         -- count = 390,187
select count(*) from epmfamilytableattribute; -- count = 6,609
select count(*) from epmfamilytableparameter; -- count = 40,297
select count(*) from epmparameterdefinition;  -- count = 6,676
select count(*) from epmparametermap;         -- count = 0
select count(*) from epmparametervalue;       -- count = 1,307,660
select count(*) from epmfamilytablecell;      -- count = 2,494,600
select count(*) from epmfamilytablecelldep;   -- count = 27,465
select count(*) from epmfamilytablemember;    -- count = 12,465

-- occurrences
select count(*) from epmoccurrencetable;      -- count = 189,767
select count(*) from epmusesoccurrence;       -- count = 140

-- wtparts
select count(*) from wtpart;            -- count = 90,766  --> Windchill WTPart objects (TBM)

