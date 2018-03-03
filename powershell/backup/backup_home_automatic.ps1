$username = $env:UserName
$time = get-date -format "yyyy-MM-dd_HH:mm:ss"

$size = (get-childitem -recurse D:\HOME\$username\ | measure-object -property length -sum).sum
$size = "{0:N2}" -f ($size / (1024 * 1024))

$count = (get-childitem D:\HOME\$username\ | measure-object).count

xcopy /Y /E /I /H D:\HOME\$username D:\BACKUP\$username

$logmessage = "USERNAME:$username - LOGTIME:$time - SIZE:$size MB - COUNT:$count Dateien"
$logmessage | out-file -filepath D:\LOGS\$username\log_backup_automatic.txt -append
