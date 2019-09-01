#Get-Alias
get-alias dir
get-alias -definition get-alias

#Get-Help
get-help get-help
get-help help -examples
get-help help -full

#Get-Command
get-command -name *service*
get-help get-command
get-command -commandtype Cmdlet -name *service*
get-command -noun *service*

#Get-Help Online - Onlinehilfe
get-help get-service -online

#Formatieren der Ausgabe mit Format Table
get-process -name w* | format-table

#Formatieren der Ausgabe mit Format List und Format Wide
get-process | format-list
get-process | format-wide




#find command for windows-event-log
get-command -verb get -noun *event*log*

#output in file
get-command -commandtype cmdlet -name *file* #search in ouput for an appropriate command

#set alias
get-command -verb set -noun *alias*
get-help set-alias -online
set OF out-file

#Variable
get-process
get-command -noun *variable*
get-help set-variable -online
get-process | set-variable processes

#print variable
$processes

#write variable into file
get-help out-file
$processes | out-file -filepath "E:\processes.txt" -encoding ascii

#print one process object properties
get-help get-process -online
get-process explorer | format-list

#process object properties
get-process | select vm
get-process | select pm
get-process | select npm
get-help measure-object -online
get-process | measure-object -property pm -average
get-process | measure-object -property vm -sum
get-process | measure-object -property vm,pm -average -sum -maximum -minimum

#sort process object
get-command -verb *sort*
get-help sort-object -online
get-process | sort-object -property pm -descending
get-process | sort-object -property pm -descending | format-table -property processname,pm
get-process | sort-object -property pm -descending | select-object -first 10 | format-table -property processname,pm



#Update Service
#get service properties, start & stop (administrator - else you'll get an error)

#Task 1
get-help get-service -online
get-service -displayname *windows*update*

#task 2
get-help stop-service -online
get-service -displayname *windows*update* | stop-service -whatif
stop-service -displayname *windows*update* -whatif

#Task 3
get-service -displayname *windows*update* | stop-service -confirm

#Task 4
get-service -displayname *windows*update* | start-service
get-service -displayname *windows*update*


#objects

#Task 1 - help
get-help get-member -full
get-help get-member -online

#Task 2 - visible member
get-service | get-member

#Task 3 - member type property
get-service | get-member -membertype property

#Task 4 - available member??
get-service | get-member -view all

#Task 5 - different views
get-service | get-member -view Base
get-service | get-member -view extended,adapted

#Task 6 - directory properties
get-command -noun *item*
get-help get-childitem -online
get-childitem -path C:\ -attributes hidden
get-childitem -path C:\ -attributes hidden | get-member -name *time*
get-childitem -path C:\ -attributes hidden | format-table -property name,creationtime,lastaccesstime,lastwritetime


#processing

#Task 1
get-command -verb *out*

#Task 2
get-help help -online
get-help get-eventlog -detailed
get-eventlog -logname system -entrytype warning -newest 100

#Task 3
get-eventlog -logname system -entrytype warning -newest 100 | out-file -filepath E:\event.log -encoding ascii

#Task 4
get-command -noun *grid*
get-help out-gridview -online
get-eventlog -logname system -entrytype warning -newest 100 | out-gridview
get-eventlog -logname system -entrytype warning -newest 100 | out-gridview | sort-object -property instanceid -descending
get-eventlog -logname system -entrytype warning -newest 100 -instanceid 134 | out-gridview