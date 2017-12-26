$logtime = get-date -format "yyyy-MM-dd_HH:mm:ss"
$username = $env:UserName

"login successfull - time:$logtime - user:$user" | out-file -filepath D:\LOGS\log_logons.txt -append