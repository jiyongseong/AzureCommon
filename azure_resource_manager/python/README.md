# Azure Python SDK

Azure Python SDK 설치 방법 : [Installing Python and the SDK](https://docs.microsoft.com/en-us/azure/python-how-to-install)

도구는 [Visual Studio Code](https://code.visualstudio.com/)를 사용하였습니다.

Azure Python SDK를 이용하여 Azure으로 로그인하기 위해서는 다음의 세 가지 인증 방법 중에 하나를 선택하여야 합니다.

- Service Principal
- AD User/Password
- ADAL

각각의 방법에 대해서는 다음의 문서에서 자세하게 설명하고 있습니다.

[Resource Management Authentication](https://azure-sdk-for-python.readthedocs.io/en/latest/quickstart_authentication.html)

여기서는 AD User/Password를 이용한 방법을 사용하게 됩니다.

## 로그인
[Azure Python을 이용하여 Azure 인증 받기](https://github.com/jiyongseong/AzureCommon/tree/master/azure_resource_manager/python/login)

## Azure 리소스 그룹 가져오기
[리소스 그룹 목록 반환](https://github.com/jiyongseong/AzureCommon/tree/master/azure_resource_manager/python/resourceGroup#리소스-그룹-목록-반환)

## Azure 리소스 그룹 생성하기
[리소스 그룹 생성](https://github.com/jiyongseong/AzureCommon/tree/master/azure_resource_manager/python/resourceGroup#리소스-그룹-생성)

## Azure 리소스 그룹 가져오기
[리소스 그룹 삭제](https://github.com/jiyongseong/AzureCommon/tree/master/azure_resource_manager/python/resourceGroup#리소스-그룹-삭제)

##참고 자료
[Azure SDK for Python](https://azure-sdk-for-python.readthedocs.io/en/latest/index.html)
