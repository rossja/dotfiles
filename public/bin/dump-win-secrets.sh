#!/bin/bash
# presumes the appropriate files are created with e.g.:
#     reg.exe save hklm\sam c:\temp\sam.save
#     reg.exe save hklm\security c:\temp\security.save
#     reg.exe save hklm\system c:\temp\system.save
python2.7 ./secretsdump.py -sam sam.save -security security.save -system system.save LOCAL
