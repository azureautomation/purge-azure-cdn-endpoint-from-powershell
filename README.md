Purge Azure CDN Endpoint from PowerShell
========================================

            

UPDATE: 2016-05-01 = Native cmdlets are available under AzureRM.Cdn module, if you need to rely only on the base AzureRM.Resources module, this script can help you limit the depedencies on other AzureRM modules. More information on latest Azure Powershell
 release here.


 


Use this script to purge an Azure CDN endpoint without relying on a bearer token or having to deal with the REST API. You can provide one or many content paths to be purged. This script will work for CDN endpoints created under the Azure
 Resource Manager API.


 


Invoking the script in you current subscription:


 

 

Invoking the script with an endpoint object:


This script requires v1.x of 
Microsoft Azure Powershell

Have fun in automating your Azure CDN!

        
    
TechNet gallery is retiring! This script was migrated from TechNet script center to GitHub by Microsoft Azure Automation product group. All the Script Center fields like Rating, RatingCount and DownloadCount have been carried over to Github as-is for the migrated scripts only. Note : The Script Center fields will not be applicable for the new repositories created in Github & hence those fields will not show up for new Github repositories.
