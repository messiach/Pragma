#!/usr/bin/python

import sys, os, re
import datetime, zipfile, fnmatch

# functions section (all functions must be defined beforehand in python!)

# writes the legal header at the beginning of a source file
def writePTCLegalHeader ( output=sys.stdout ):
    now = datetime.datetime.now()
    output.write("/*\n" +
                   " * bcwti\n" + 
                   " * Copyright (c) %s Parametric Technology Corporation (PTC). All Rights\n" % (now.year) + 
                   " * Reserved.\n" + 
                   " * This software is the confidential and proprietary information of PTC\n" + 
                   " * and is subject to the terms of a software license agreement. You shall\n" + 
                   " * not disclose such confidential information and shall use it only in accordance\n" + 
                   " * with the terms of the license agreement.\n" + 
                   " * ecwti\n" + 
                   " */\n")

# setup the dictionary (hash) of classname=>fully-qualified classname mappings
def getWTLibDictionary ( libDir='d:\\wclibs\\9.1M050', libPath='d:\\ptc\\library_paths_py.txt'):
    
    # setup the dictionary
    wtlibs = {}
    
    # check for libPath first
    if (os.path.exists(libPath)):
        # gather dictionary values from libPath file
        infile = open(libPath, 'r')
        for line in infile:
            strList = line.rstrip('\n').split('=')
            wtlibs[strList[-2]] = strList[-1]
        infile.close()
    
    # gather dictionary values directly from the jar files in the libDir    
    else:
        # get a listing of the libDir
        listing = scandirsforjars(libDir)
        for file in listing:
            zf = zipfile.ZipFile(file)
            for info in zf.infolist():
                # using info.filename, get the dictionary mapping
                strList = re.split("\/|\.", info.filename)
                if strList[-1] == 'class':
                    wtlibs[strList[-2]] = info.filename
                else:
                    continue
        
        # create the cache libPath file
        outfile = open(libPath, 'w')
        for key in wtlibs.keys():
            outfile.write(key + "=" + wtlibs[key] + "\n")
        outfile.close()
    
    return wtlibs
            
    
# recursively scan subdirectories for only *.jar files        
def scandirsforjars ( path ):
    listing = []
    for dirpath, dirnames, filenames in os.walk(path):
        for dirname in dirnames:
            listing.extend(scandirsforjars(dirname))
        names = fnmatch.filter(filenames, '*.jar')
        for name in names:
            listing.append(os.path.join(dirpath, name))
    return listing
           
 
 

        
        
### TESTING SECTION
wtlibs = getWTLibDictionary()
for klass in wtlibs.keys():
    print(klass + "=" + wtlibs[klass])
    
    
