
Clear-Host
$outputFilePath = ".\VMs.csv" 

Write-Host "Requesting Pricing Information from https://azure.microsoft.com/api/v1/pricing/virtual-machines/calculator/" -BackgroundColor Yellow -ForegroundColor Red

$r = Invoke-WebRequest -Uri "https://azure.microsoft.com/api/v1/pricing/virtual-machines/calculator/?culture=ko-kr"


<#
($r.Content | ConvertFrom-Json).offers 
($r.Content | ConvertFrom-Json).tiers
($r.Content | ConvertFrom-Json).types
($r.Content | ConvertFrom-Json).sizes

($r.Content | ConvertFrom-Json).regions
($r.Content | ConvertFrom-Json).resources
($r.Content | ConvertFrom-Json).softwareLicenses
#>

Write-Host "Exporting.............." -BackgroundColor Yellow -ForegroundColor Red

$offers = ($r.Content | ConvertFrom-Json) | Select -expand offers 

$vms = $offers.psobject.properties.name

foreach ($vm in $vms)
{
    Write-Host "Exporting $vm  ...."
    $core = ($offers | Select -ExpandProperty  $vm.ToString()).cores
    $ram = ($offers | Select -ExpandProperty  $vm.ToString()).ram
    $disksize = ($offers | Select -ExpandProperty  $vm.ToString()).disksize
    #$sku = ($offers | Select -ExpandProperty  $vm.ToString()).skus
    $prices = ($offers | Select -ExpandProperty $vm.ToString()).prices 
    
    $regions = $prices.psobject.properties.name
    
    foreach ($region in $regions)
    {
        $price = ($prices | Select -ExpandProperty $region.ToString())

        $names = $vm.Split("-")

        switch ($names.Count)
        {
            3 { $prod = $names[0]}
            4 { $prod = $names[0]+" "+$names[1]}
            5 { $prod = $names[0]+" "+$names[1]+" "+$names[2]}
        }

        $row = New-Object PSObject

        $row | Add-Member -MemberType NoteProperty -Name "Core" -Value $core
        $row | Add-Member -MemberType NoteProperty -Name "RAM" -Value $ram
        $row | Add-Member -MemberType NoteProperty -Name "DiskSize" -Value $disksize
        $row | Add-Member -MemberType NoteProperty -Name "Region" -Value $region
        $row | Add-Member -MemberType NoteProperty -Name "Price" -Value $price
        $row | Add-Member -MemberType NoteProperty -Name "Product" -Value $prod
        $row | Add-Member -MemberType NoteProperty -Name "Tier" -Value $names[-2]
        $row | Add-Member -MemberType NoteProperty -Name "Type" -Value $names[-1]

        $row| Select-Object -Property Product, Tier, Type, Core, RAM, DiskSize, Region, Price | Export-Csv -Path $outputFilePath -NoTypeInformation -Append
    } 
}

Write-Host "Done." -BackgroundColor Yellow -ForegroundColor Red