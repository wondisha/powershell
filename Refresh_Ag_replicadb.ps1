$server= instance
$dbname=databasename
$ProdBackup=Prodbackup
$PrimaryFbackup =fullbackup
$primarylbackup=logbackup
$agname=availabilitygroup
#Get the primary and secondary replica
Get-DbaAgReplica -SqlInstance $server
#check if the instance is primary
Get-DbaAvailabilityGroup -SqlInstance $server -IsPrimary
#Remove db from primary replica
Remove-DbaAgDatabase -sqlinstance $server -database $dbname -availabilitygroup $agname

#Restore the database from latest Prod Backup

Restore-DbaDatabase -SqlInstance $server -DatabaseName $dbname -path $ProdBackup
#Take full and log backup of primary
Backup-DbaDatabase -SqlInstance $server -Database $dbname -path 'backup path.bak' -Type Full
Backup-DbaDatabase -SqlInstance $Server -Database $dbname -path 'backupa path.trn' -Type Log

#Restore Full and Log to the secondary with no recovery
Restore-DbaDatabase -SqlInstance $server -DatabaseName $dbname -path $PrimaryFbackup -NoRecovery
Restore-DbaDatabase -SqlInstance $server -DatabaseName $dbname -path $primarylbackup -NoRecovery
#Rejoin Database to availability Group#3
Add-DbaAgDatabase -SqlInstance $server -AvailabilityGroup $agname -Database dbname -Confirm
Add-DbaAgDatabase -SqlInstance $server -AvailabilityGroup $agname -Database dbname -confirm