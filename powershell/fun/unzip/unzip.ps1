## 다른 사람이 만든 것임
## ref : https://www.howtogeek.com/tips/how-to-extract-zip-files-using-powershell/

function Expand-ZIPFile($file, $destination)
{
    $shell = new-object -com shell.application
    $zip = $shell.NameSpace($file)
    foreach($item in $zip.items())
    {
        $shell.Namespace($destination).copyhere($item)
    }
}

$src = '<<원본 파일 경로>>'
$dest = '<<대상 경로>>'


$files = Get-ChildItem -Path $src -Filter *.zip

foreach ($file in $files){
    Expand-ZIPFile –File $file.FullName –Destination $dest
}
