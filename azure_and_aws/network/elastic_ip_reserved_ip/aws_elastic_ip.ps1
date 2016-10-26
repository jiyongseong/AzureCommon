#http://docs.aws.amazon.com/ko_kr/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html

Get-AWSCredentials -ListProfiles

$profileName = "default"
$region = "ap-southeast-2"

Initialize-AWSDefaults -ProfileName $profileName -Region $region

New-EC2Address -Domain standard

Get-EC2Address

$allocationId = "eipalloc-########"

Remove-EC2Address -AllocationId $allocationId -Force


