##Import-Module dbachecks, dbatools
<# $sqlinstances = Get-DbaRegserver -Group SQLCMS
$testResults = Invoke-DbcCheck -SqlInstance $sqlinstances -Check  DatabaseStatus -PassThru#>

<#$testResults|convert-dbcresult|Write-DbcTable -SqlInstance 'DESKTOP-833QAHA\SQL_01' -Database monitor |
Select-Object Describe, Context, Name, Result, FailureMessage |
Export-Csv d:\temp\backups.csv -NoTypeInformation#>

## Dbachecks Database Connection
$dbachecksServer = 'DESKTOP-833QAHA\SQL_01'
$dbachecksDatabase = 'Monitor'
 
## Define instances and checks to run
$SqlInstance = Get-DbaRegserver -Group SQLCMS
$checks = 'sadisabled','autoclose'
 
Invoke-DbcCheck -SqlInstance $SqlInstance -Checks $checks  -PassThru |
Convert-DbcResult -Label 'MorningChecks' |
Write-DbcTable -SqlInstance $dbachecksServer -Database $dbachecksDatabase

$testResults.TestResult|
Select-Object Context, Name,Describe,Result, FailureMessage |
Export-Excel @excelsplat -FreezeTopRow -BoldTopRow

$ConditionalFormat =$(
    New-ConditionalText -Text Failed -Range 'D:D'
)
  
$excelSplat = @{
    Path               = 'd:\Temp\Backups.xlsx'
    WorkSheetName      = 'TestResults'
    TableName          = 'checkresults'
    Autosize           = $true
    ConditionalFormat  = $ConditionalFormat
    IncludePivotTable  = $true
    PivotRows          = 'Describe'
    PivotData          = @{Describe='Count'}
    PivotColumns       = ''
    IncludePivotChart  = $true
    ChartType          = 'ColumnStacked'
}
  


<#Start-DbcPowerBi -FromDatabase   

#####Get-DbaRegServer |Get-DbaDatabase where OWNER -eq sa####>