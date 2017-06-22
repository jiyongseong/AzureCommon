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

def create_resource_group(resource_group_name, location):

    if resource_client.resource_groups.check_existence(resource_group_name):
        print (resource_group_name + " is already existing.\ntry other name.")
        return;
    else:
        resource_client.resource_groups.create_or_update(resource_group_name, {'location':location})
        print ("Successfully created {0} Resoure Group\nregion :{1}".format(resource_group_name, location));

def delete_resource_group(resource_group_name):

    if resource_client.resource_groups.check_existence(resource_group_name):
        resource_client.resource_groups.delete(resource_group_name)
        print ("Successfully deleted {0} Resoure Group".format(resource_group_name));
    else:
        print ("Resource group '" + resource_group_name + "' does not exist.\ncheck the name.")
        return;
        