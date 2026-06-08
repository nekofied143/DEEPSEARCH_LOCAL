Clear-Host

while ($true)
{
Clear-Host

Write-Host "========================================="
Write-Host "      SMART DEEP SEARCH TOOL v2"
Write-Host "========================================="
Write-Host ""

$keyword = Read-Host "Enter keyword"

if ([string]::IsNullOrWhiteSpace($keyword))
{
    continue
}

Write-Host ""
Write-Host "Searching..."
Write-Host ""

$query = @"


SELECT System.ItemPathDisplay
FROM SYSTEMINDEX
WHERE FREETEXT('$keyword')
"@


$results = @()

try
{
    $conn = New-Object System.Data.OleDb.OleDbConnection(
        "Provider=Search.CollatorDSO;Extended Properties='Application=Windows';"
    )

    $conn.Open()

    $cmd = $conn.CreateCommand()
    $cmd.CommandText = $query

    $reader = $cmd.ExecuteReader()

    while ($reader.Read())
    {
        $path = $reader.GetString(0)

        if (
            $path -match '^[CD]:\\' -and
            $path -match '\.(docx|xlsx|pdf)$'
        )
        {
            $results += $path
        }
    }

    $conn.Close()
}
catch
{
    Write-Host ""
    Write-Host "ERROR:" -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Red
    Write-Host ""

    Pause
    Clear-Host
    continue
}

if ($results.Count -eq 0)
{
    Write-Host "No matching documents found."
    Write-Host ""

    Pause
    Clear-Host
    continue
}

Write-Host "Found $($results.Count) matching document(s)."
Write-Host ""
Write-Host "========================================="
Write-Host ""

for ($i = 0; $i -lt $results.Count; $i++)
{
    Write-Host "$($i + 1). $($results[$i])"
}

Write-Host ""
Write-Host "========================================="
Write-Host ""

$choice = Read-Host "Enter numbers to open (e.g. 1 3 5), S=Search Again, E=Exit"

if ($choice.ToUpper() -eq "E")
{
    break
}

if ($choice.ToUpper() -eq "S")
{
    Clear-Host
    continue
}

foreach ($n in ($choice -split '\s+'))
{
    if ($n -match '^\d+$')
    {
        $index = [int]$n - 1

        if ($index -ge 0 -and $index -lt $results.Count)
        {
            Start-Process $results[$index]
        }
        else
        {
            Write-Host "Invalid selection: $n" -ForegroundColor Yellow
        }
    }
}

Write-Host ""
Pause


}
