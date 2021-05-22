$SQLinstance ='DESKTOP-833QAHA\SQL_2019_TRAIN'
$Path = 'D:\New folder\query.csv'
$cred = Get-DbaCredential
$query='SELECT      r.start_time [Start Time],session_ID [SPID],
            DB_NAME(database_id) [Database],
            SUBSTRING(t.text,(r.statement_start_offset/2)+1,
            CASE WHEN statement_end_offset=-1 OR statement_end_offset=0
            THEN (DATALENGTH(t.Text)-r.statement_start_offset/2)+1
            ELSE (r.statement_end_offset-r.statement_start_offset)/2+1
            END) [Executing SQL],
            Status,command,wait_type,wait_time,wait_resource,
            last_wait_type
FROM        sys.dm_exec_requests r
OUTER APPLY sys.dm_exec_sql_text(sql_handle) t
'

Invoke-DbaQuery -SqlInstance $SQLinstance -Query $query -SqlCredential $cred |
export-csv -Path $Path