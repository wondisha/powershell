##Refreshing Availability database##
#Declare variable for credential with secure string
$password = ConvertTo-SecureString 'MySecretPassword' -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ('root', $password)
#Get the primary and secondary replica
Get-DbaAgReplica -SqlInstance instance
#check if the instance is primary
Get-DbaAvailabilityGroup -SqlInstance instance -SqlCredential $cred -IsPrimary
#Remove db from primary replica
Remove-DbaAgDatabase -sqlinstance instance -database dbname -availabilitygroup

#Restore the database from latest Prod Backup

Restore-DbaDatabase -SqlInstance instance -DatabaseName dbname -path 'backup path'
#Take full and log backup of primary
Backup-DbaDatabase -SqlInstance instance -Database dbname -path 'backup path.bak' -Type Full
Backup-DbaDatabase -SqlInstance instance -Database dbname -path 'backupa path.trn' -Type Log

#Restore Full and Log to the secondary with no recovery
Restore-DbaDatabase -SqlInstance instance -DatabaseName dbname -path 'backup from primary.bak' -NoRecovery
Restore-DbaDatabase -SqlInstance instance -DatabaseName dbname -path 'back up from primary.trn' -NoRecovery
#Rejoin Database to availability Group#3
Add-DbaAgDatabase -SqlInstance instance -AvailabilityGroup agname -Database dbname -Confirm
Add-DbaAgDatabase -SqlInstance instance -AvailabilityGroup agname -Database dbname -confirm