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