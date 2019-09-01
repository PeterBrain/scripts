set-alias gel get-eventlog
set-alias of out-file
get-alias gel
get-alias of

#get-command -verb set -noun *execution*,*policy*
#get-help set-executionpolicy -online
set-executionpolicy -executionpolicy remotesigned
#get-process
get-process | format-table -property processname,pm,vm -autosize
#out-file -filepath C:\Users\User\Desktop\powershell\ps.ps1 -encoding ascii
"set-alias gel get-eventlog" | out-file -filepath C:\Users\User\Desktop\powershell\ps.ps1 -encoding ascii -append
"set-alias of out-file" | out-file -filepath C:\Users\User\Desktop\powershell\ps.ps1 -encoding ascii -append
"get-alias gel" | out-file -filepath C:\Users\User\Desktop\powershell\ps.ps1 -encoding ascii -append
"get-alias of" | out-file -filepath C:\Users\User\Desktop\powershell\ps.ps1 -encoding ascii -append
