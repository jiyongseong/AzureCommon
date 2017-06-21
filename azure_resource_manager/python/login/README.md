# Azure Python을 이용하여 Azure 인증 받기

Azure Python SDK를 이용하여 Azure으로 로그인하기 위해서는 다음의 세 가지 인증 방법 중에 하나를 선택하여야 합니다.

- Service Principal
- AD User/Password
- ADAL

각각의 방법에 대해서는 다음의 문서에서 자세하게 설명하고 있습니다.

[Resource Management Authentication](https://azure-sdk-for-python.readthedocs.io/en/latest/quickstart_authentication.html)

여기서는 AD User/Password를 이용한 방법을 사용하게 됩니다.

해당 코드는 다음과 같습니다.

```python
import getpass
from azure.common.credentials import UserPassCredentials
from azure.mgmt.resource.resources import ResourceManagementClient

def azureADUserLogin():
    azureUserName = input("Enter your AD user address : ")
    azureUserPassword = getpass.getpass('Enter your password:')
    subscription_id = input("Enter your subscription id : ")
     
    credentials = UserPassCredentials(azureUserName, azureUserPassword)
    resource_client = ResourceManagementClient(credentials, subscription_id)

    return resource_client
```
다음과 같이, Python에서 실행을 하면

```{r, engine='bash', count_lines}
>>> exec(open('./Documents/Python/azure/login/azureADUserLogin.py').read())
>>> azureADUserLogin()
```

Azure AD 계정과 비밀번호를 입력을 요구하게 됩니다.
해당 정보를 구독 번호와 함께 입력합니다. (구독 정보를 확인하는 방법은 [다음](https://blogs.msdn.microsoft.com/mschray/2016/03/18/getting-your-azure-subscription-guid-new-portal/)과 같습니다.)

구독 정보를 입력하고 'Enter'를 누르면, 다음과 같이 인증된 클라이언트 개체를 반환 받게 됩니다.

![](https://jyseongfileshare.blob.core.windows.net/images/python-login-01.png)

Azure와 관련된 작업을 위해서는 Azure로부터 인증을 받아야 하기 때문에, 해당 함수를 반드시 실행해주어야 합니다.