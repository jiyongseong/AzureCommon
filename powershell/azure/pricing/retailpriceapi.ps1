#https://docs.microsoft.com/en-us/rest/api/cost-management/retail-prices/azure-retail-prices

$content = (Invoke-WebRequest -Uri 'https://prices.azure.com/api/retail/prices?$filter=ArmRegionName%20eq%20%27koreacentral%27').content
$items =  ($content | ConvertFrom-Json).items
$items | Where-Object skuName -Like  'M2*' | Select armRegionName, productName, location,  skuName, unitOfMeasure, retailPrice
