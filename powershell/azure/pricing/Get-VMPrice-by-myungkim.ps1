
function createOutputObject
{
    $row = New-Object PSObject

    $row | Add-Member -MemberType NoteProperty -Name "Product" -Value ""
    $row | Add-Member -MemberType NoteProperty -Name "Tier" -Value ""
    $row | Add-Member -MemberType NoteProperty -Name "Type" -Value ""
    $row | Add-Member -MemberType NoteProperty -Name "Core" -Value ""
    $row | Add-Member -MemberType NoteProperty -Name "RAM" -Value ""
    $row | Add-Member -MemberType NoteProperty -Name "DiskSize" -Value ""       
    $row | Add-Member -MemberType NoteProperty -Name "Region" -Value ""
    $row | Add-Member -MemberType NoteProperty -Name "Price" -Value ""

    $row
}

function getvms()
{
    Clear-Host
    $outputFilePath = ".\VMs.csv"
    Remove-Item $outputFilePath -ErrorAction Ignore

    Write-Host "Requesting Pricing Idirnformation from https://azure.microsoft.com/api/v1/pricing/virtual-machines/calculator/" -BackgroundColor Yellow -ForegroundColor Red

    $r = Invoke-WebRequest -Uri "https://azure.microsoft.com/api/v1/pricing/virtual-machines/calculator/?culture=ko-kr"
    Write-Host "Exporting.............." -BackgroundColor Yellow -ForegroundColor Red

    $offers = ($r.Content | ConvertFrom-Json) | Select -expand offers 

    $vms = $offers.psobject.properties.name

    $resultSet = [System.Collections.ArrayList]@()
    $row = createOutputObject
    
    foreach ($vm in $vms)
    {
        Write-Host "Exporting $vm  ...."

        $row.Core = ($offers | Select -ExpandProperty  $vm.ToString()).cores
        $row.RAM = ($offers | Select -ExpandProperty  $vm.ToString()).ram
        $row.DiskSize = ($offers | Select -ExpandProperty  $vm.ToString()).disksize
        
        $prices = ($offers | Select -ExpandProperty $vm.ToString()).prices 
        $regions = $prices.psobject.properties.name
       
        foreach ($region in $regions)
        {
            $row.Region = $region
            $row.Price = ($prices | Select -ExpandProperty $region.ToString())
            $row.Product = $vm.Replace("-", " ")
                        
            $names = $vm.Split("-")
            $row.Tier = $names[-2]
            $row.Type = $names[-1]

            $resultSet.Add($row.PsObject.Copy()) | Out-Null
            
        } 

    }
    
    $resultSet | Export-Csv -Path $outputFilePath -NoTypeInformation 

    Write-Host "Done." -BackgroundColor Yellow -ForegroundColor Red 
}

getvms 
