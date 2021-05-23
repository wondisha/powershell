#Declare variable for credential with secure string
$password = ConvertTo-SecureString 'MySecretPassword' -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ('root', $password)
#Define registered servers for sql instance
$sqlinstance = Get-DbaRegserver -Group SQLCMS
## Dbachecks Database Connection
$dbachecksServer = 'DESKTOP-833QAHA\SQL_01'
$dbachecksDatabase = 'Monitor'
 
## Define instances and checks to run
$SqlInstance = Get-DbaRegserver -Group SQLCMS
$checks = 'sadisabled','autoclose'
 
Invoke-DbcCheck -SqlInstance $SqlInstance -SqlCredential $cred -Checks $checks  -PassThru |
Convert-DbcResult -Label 'DailyChecks' |
Write-DbcTable -SqlInstance $dbachecksServer -Database $dbachecksDatabase

