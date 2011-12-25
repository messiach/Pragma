#!/usr/bin/python

import re

# functions section

# script section

# read from the report file
infile = open('./report_data/CabinetBasedDataContainerAlignmentReport.txt', "r")
report_data = infile.readlines();
infile.close()

# setup the data dictionary
raw_data_dict = {}

# parse the important data from the input data
#  parses object->container and cabinet->container and creates the association
obj = containerName = cabinet = cabinetContName = ''

# setup the iterator for the lines data
it = iter(report_data)
for line in it:  
    
    # will step through each line after a match is found
    pattern = re.compile('Data:')
    if (pattern.search(line)!=None):
        obj = ((re.split(":", line, 1))[1]).rstrip('\n')    # get the object
        line = it.next()
        
        pattern = re.compile('Container:')
        if (pattern.search(line)!=None):
            containerName = ((re.split(":", line, 1))[1]).rstrip('\n') # get the object's container name
            line = it.next()
                 
            pattern = re.compile('Cabinet')
            if (pattern.search(line)!=None):
                cabinet = ((re.split(":", line, 1))[1]).rstrip('\n')   # get the object's cabinet
                line = it.next()
                
                pattern = re.compile('Container')
                if (pattern.search(line)!=None):
                    cabinetContName = ((re.split(":", line, 1))[1]).rstrip('\n')   # get the cabinet's container name
        
        # check if a full match was found
        if (obj!='' and containerName!='' and cabinet!='' and cabinetContName!=''):
            
            # build the dictionary value list
            valuelist = [{obj:containerName}, {cabinet:cabinetContName}]            
            raw_data_dict[obj] = valuelist
            
            # reset the macthing stores
            obj = containerName = cabinet = cabinetContName = '' 
        
        # no full match - skip and alert user    
        else:
            print('Full match not found on line: ' + line)

                    
                    

# prepare the raw data output file
outfile = open('./report_data/raw_data.txt', 'w')

# write the raw data 
for k, v in raw_data_dict.items():
    outfile.write(k + "=\n")
    for item in v:
        for key in item.keys():
            outfile.write(key + ":" + item[key] + '\n')
    outfile.write('\n\n') 
outfile.close()