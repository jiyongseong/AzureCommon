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
