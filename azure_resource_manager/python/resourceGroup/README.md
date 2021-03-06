# Azure Python을 이용하여 Azure Resource Group 반환하기

## 리소스 그룹 목록 반환
다음의 코드를 이용하면, 전체 리소스 그룹 또는 지정된 리소스 그룹의 정보를 반환할 수 있습니다.

```python
import sys, os
#sudo pip install prettytable
from prettytable import PrettyTable

sys.path.append(os.path.abspath("../login/"))
from azureADUserLogin import *

resource_client = azure_ad_user_login()

def list_resource_group(resource_group_name=""):

    rgTable = PrettyTable(['Name','Location'])

    if resource_group_name == "":
        for item in resource_client.resource_groups.list():
            rgTable.add_row([item.name,item.location])
        print(rgTable);
    else:
        if resource_client.resource_groups.check_existence(resource_group_name):
            rg = resource_client.resource_groups.get(resource_group_name)
            rgTable.add_row([rg.name,rg.location])
            print(rgTable);
        else:
            print ("There is no resource group named " + resource_group_name);

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

## 리소스 그룹 생성
리소스 그룹은 다음의 명령을 이용하여 생성할 수 있습니다.

```python
def create_resource_group(resource_group_name, location):

    if resource_client.resource_groups.check_existence(resource_group_name):
        print (resource_group_name + " is already existing.\ntry other name.")
        return;
    else:
        resource_client.resource_groups.create_or_update(resource_group_name, {'location':location})
        print ("Successfully created {0} Resoure Group\nregion :{1}".format(resource_group_name, location));
```

## 리소스 그룹 삭제
리소스 그룹은 다음의 명령을 이용하여 삭제할 수 있습니다.

```python
def delete_resource_group(resource_group_name):

    if resource_client.resource_groups.check_existence(resource_group_name):
        resource_client.resource_groups.delete(resource_group_name)
        print ("Successfully deleted {0} Resoure Group".format(resource_group_name));
    else:
        print ("Resource group '" + resource_group_name + "' does not exist.\ncheck the name.")
        return;
```