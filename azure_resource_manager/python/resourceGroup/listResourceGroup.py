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