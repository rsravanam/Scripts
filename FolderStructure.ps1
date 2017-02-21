$latestpath = "D:\test\DBLatestBackup"
$prevpath = "D:\test\DBPrevBackup"
$paths = @("$latestpath","$prevpath")

foreach($path in $paths)
{
If(!(test-path $path)){
New-Item -type Directory -Force -Path $path
Write-Output "$path Not exixts, created!!"
}
else{
Write-Output "$path exists"
}
}
If((test-path $latestpath)){
Write-Output "backup db started"
Copy-Item -Path $latestpath\*.bak -Destination $prevpath -Force -Recurse
Write-Output " "
Remove-Item -Path $latestpath\*.bak
Invoke-Sqlcmd -AbortOnError -ServerInstance testserver -Username test -Password test  -Database pubs -Query "BACKUP DATABASE [pubs] TO DISK='$latestpath\BackupsMyDB.bak'"

Write-Output "backup ok"
}else{
Write-Output "$latestpath does not exists"
}