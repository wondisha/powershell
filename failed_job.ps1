#create failed jobs report########
$sqlinstances = 'DESKTOP-833QAHA\SQL_2019_TRAIN','DESKTOP-833QAHA\SQL_01'
$testResults = Invoke-DbcCheck -SqlInstance $sqlinstances -Check FailedJob -PassThru

$testResults | Convert-DbcResult|Write-DbcTable -SqlInstance 'DESKTOP-833QAHA\SQL_01' -Database nm |
Select-Object Describe, Context, Name, Result, FailureMessage 

$ConditionalFormat =$(
    New-ConditionalText -Text Failed -Range 'D:D'
)
  
$excelSplat = @{
    Path               = 'd:\dbc_out\Backups.xlsx'
    WorkSheetName      = 'TestResults'
    TableName          = 'Results'
    Autosize           = $true
    ConditionalFormat  = $ConditionalFormat
    IncludePivotTable  = $true
    PivotRows          = 'Describe'
    PivotData          = @{Describe='Count'}
    PivotColumns       = 'Result'
    IncludePivotChart  = $true
    ChartType          = 'ColumnStacked'
}
  
$testResults.TestResult |
Select-Object Describe, Context, Name, Result, FailureMessage |
Export-Excel @excelSplat