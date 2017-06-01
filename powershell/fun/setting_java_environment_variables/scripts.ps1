## run as administrator
[Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Java\jdk1.8.0_131", "Machine")
$env:Path += "%JAVA_HOME%\bin"

## check
[Environment]::GetEnvironmentVariable("JAVA_HOME", "Machine")
$path = Get-Item Env:Path | Select value
$path.Value.Split(";")