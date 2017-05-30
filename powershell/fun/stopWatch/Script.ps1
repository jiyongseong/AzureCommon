$stopWatch = New-Object -TypeName System.Diagnostics.Stopwatch
$stopWatch.Start()

Get-Command -Name *Azure*

$stopWatch.Elapsed