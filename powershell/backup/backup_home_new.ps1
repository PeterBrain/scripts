$username = $env:USERNAME
$logtime = get-date -format "yyyy-MM-dd_HH-mm-ss"
$logmessage = USERNAME:$username - TIME:$logtime - SIZE:$size bytes - AMOUNT:$amount Dateien

set-variable -name size -value (get-childitem -recurse D:\Home\$username | measure-object length -sum).sum
set-variable -name amount -value (get-childitem D:\Home\$username | measure-object).count

xcopy /Y /D /H D:\HOME\$username D:\BACKUP\$username

$logmessage | out-file -filepath D:\LOGS\$username\log_backup_manual.txt -append