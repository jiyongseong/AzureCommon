# Azure Python을 이용하여 Azure Resource Group 반환하기

다음의 코드를 이용하면, 전체 리소스 그룹 또는 지정된 리소스 그룹의 정보를 반환할 수 있습니다.

```python
import sys, os
#sudo pip install prettytable
from prettytable import PrettyTable

sys.path.append(os.path.abspath("../login/"))
from azureADUserLogin import *

resource_client = azureADUserLogin()

def listResourceGroup(resourceGroupName=""):

    rgTable = PrettyTable(['Name','Location'])

    if resourceGroupName == "":
        for item in resource_client.resource_groups.list():
            rgTable.add_row([item.name,item.location])
        print(rgTable);
    else:
        rg = resource_client.resource_groups.get(resourceGroupName)
        rgTable.add_row([rg.name,rg.location])
        print(rgTable);
```

login 모듈을 사용하여야 하므로 [여기](https://github.com/jiyongseong/AzureCommon/tree/master/azure_resource_manager/python/login)에 있는 로그인 모듈도 같이 사용하여야 합니다.
다운로드한 로그인 모듈의 위치를 상황에 맞게 아래 코드에서 수정하여야 합니다.

```python
sys.path.append(os.path.abspath("../login/"))
```

전체 목록 반환은 다음과 같습니다.

![](https://jyseongfileshare.blob.core.windows.net/images/python-resourceGroup-01.png)

특정 리소스 그룹은 다음과 같이 사용하여 반환할 수 있습니다.

![](https://jyseongfileshare.blob.core.windows.net/images/python-resourceGroup-02.png)
