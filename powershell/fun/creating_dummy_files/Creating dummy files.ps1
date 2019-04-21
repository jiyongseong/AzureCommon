$folder='E:\basefiles\'
#$name = 'VM000'
$extension = 'dat'
$size = 44GB
$amount = 20

Remove-Item -Path $folder'\*.*' -Force
New-Item -ItemType "Directory" -Path $folder -Force

$StopWatch = [System.Diagnostics.Stopwatch]::StartNew()

for($i = 1; $i -le $amount; $i++)
{

    #$seq = "0" * (2- $i.ToString().Length) + $i.ToString()
    #$path = $folder + '\' + $name + '_' + $prefix +'_' + $seq + '.' + $extension

    $path = $folder + '\' + -join ((48..57) + (65..90) + (97..122) | Get-Random -Count 12 | % {[char]$_}) + '.' + $extension
    $file = [io.file]::Create($path)
    $file.SetLength($size)
    $file.Close() | Out-Null

    Write-Host $i'th file of '$amount' is created' -BackgroundColor Yellow
}
$StopWatch.Elapsed