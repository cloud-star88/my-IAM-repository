PROJECT GROUP: GROUP 4 
NAME: ESTHER OLUCHI ISRAEL-OLAWEPO
REG. NO: AWS/2025/TC3/057
DATE: 10TH OCTOBER, 2025
TITLE: IAM ROLES AND SECURE ACCESS AUTOMATION 

OBJECTIVE:  Automate the setup of secure identity and access controls using Azure CLI and Bash scripting. 

TASKS:
1.	Create a resource group, virtual network, and subnets (Web and DB).
2.	Create Azure AD groups: ‘WebAdmin’ and ‘DBAdmin’.
3.	Assign Reader role to DBAdmins for DB subnet resources.
4.	Add test users to the AD groups and validate role assignments.

BONUS: Include scripts to revoke access or remove roles for cleanup, also using a CI/CD pipeline to automate the whole process.

Removte repo link: https://github.com/cloud-star88/my-IAM-repository



 
TASK 1:  Create a resource group, virtual network, and subnets (Web and DB)
1.	I started by creating my folders where my code, dependencies, configurations, architecture, screenshots, deployment and automations steps will be kept.
2.	I created the root folder first, followed by subfolders 
3.	Then I opened my Bash CLI
4.	I opened my Azure GUI on the portal and logged into my account 


![Workflow display ](./screenshots/azure-login-on-gui.png)
Azure login on GUI

5.	I opened my azure account on bash using ‘az login’, after that, my subscription name, ID and other details was displayed.
6.	I typed 1 + ENTER key and my first subscription was selected as default
7.	I am now being logged into my Azure CLI


![Workflow display ](./screenshots/azure-login-on-cli.png)
Azure Login CLI

8.	I entered details in one script for my resource group, virtual network and subnets to be created using the  'az commands’ and other instructions.
9.	When it was created the confirmation and details were listed
10.	The resource group is also shown on CLI and portal
 

![Workflow display ](./screenshots/resource-group-on-cli.png)
Resource Group on CLI

 
![Workflow display ](./screenshots/resource-group-on-azure-portal.png)
Resource Group in Azure portal

11.	After resource group, the next command followed suite within the same script.
12.	Using the following variables with other commands the virtual network was successfully created:  


![Workflow display ](./screenshots/virtual-network-created-on-cli.png)
Virtual network created on CLI

![Workflow display ](./screenshots/virtual-network-created-on-azure-portal.png)
Virtual network created in Azure portal

![Workflow display ](./screenshots/subnet-created-on-cli.png)
Subnet created on CLI

 ![Workflow display ](./screenshots/subnet-created-in-azure-portal.png)
Subnet created in Azure portal

TASK 2: Create Azure AD groups for WebAdmin and DBAdmin
One the same script, the command for AD group creation ran after the previous command, and the AD Group for WebAdmin and DBAdmin was created.

![Workflow display ](./screenshots/ad-group-for-webadmin-and-dbadmin-on-cli.png)
AD Group for WebAdmin and DBAdmin on CLI

The command 'az ad group list –output table’ was ran on CLI to show the two AD groups are present.
Checking the portal as well confirms the two AD groups are present
 
 ![Workflow display ](./screenshots/ad-group-for-webadmin-and-dbadmin-in-the-portal.png)
AD Group for WebAdmin and DBAdmin in the portal


Searching for 'Microsoft Entra ID' on the search bar, under management shows two AD Groups.
TASK 3: Assign Reader role to DBAdmins for DBSubnet resources 
The script to assign roll followed on but was not successful, as Bash was unable to process this command despite all credentials made available. 

Image below shows the errors encountered trying to assign DBAdmins for DBSubnet resources.
 
 
 ![Workflow display ](./screenshots/role-assignment-page-on-cli.png)
Role assignment page on CLI

I decided to try Powershell. I created a script named asignrole.ps1 and saved it I used az login to access my account from powershell
 

 ![Workflow display ](./screenshots/login-to-my-azure-account-from-powershell.png)
Login to my Azure account from Powershell



 ![Workflow display ](./screenshots/first-error-encountered-trying-to-run-same-command-on-powershell.png)
first error encountered trying to run same command on powershell as used in bash, I corrected it using backward slash.

•	I tried again and another error was flagged, indicating that running script on the system is disabled.
•	I checked for how to rectify it, and I ran the command to install module.
(Install-Module -Name Az -AllowClobber -Scope CurrentUser -Force)

 ![Workflow display ](./screenshots/module-installed-in-PowerShell.png)
Module installed in PowerShell

•	Followed by this to set execution policy
(Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser)
 

![Workflow display ](./screenshots/instruction-to-set-execution-policy.png)
Instruction to Set-ExecutionPolicy to allow role assign

•	I ran a command to get my azure subscription ID but saw an error message due to an omission of subscription ID which I added and the system requested I login again and I did and selected my subscription from the list of subscriptions displayed.
•	I ran the following command to get subscription and this time it worked.
(Get-AzSubscription Set-AzContext -SubscriptionId "your-subscription-id")
 
 ![Workflow display ](./screenshots/powershell-connected-to-my-azure-account.png)
PowerShell connected to my Azure account after entering Connect-AzAccount


•	I ran the role assign script on powershell for the last time and the roles for DBAdmin under DBSubnet was successfully assigned.

![Workflow display ](./screenshots/script-to-assign-role-in-powershell-created.png)
Script to assign role in PowerShell created

•	The roles was successfully assigned to DBAdmin for DBSubnet

![Workflow display ](./screenshots/role-name-and-id-created.png)
Role name and ID created
•	Role is confirmed on my Azure portal
 
![Workflow display ](./screenshots/role-is-assigned-to-dbadmin.png)
Role is assigned to DBAdmin 

TASK 4: Add test users to the AD groups and validate role assignments.
•	For this task, I created another PowerShell script titled create.user.ps1 and wrote my script into it to perform the required function.
•	I ran the script and there was an error, the error persisted until I decided to separate the script to carry out the separate assignments in the task.
•	I created another script, named it test_users.ps1, adjusted code and ran.
•	I ran them separately and the following are my results.		
 
![Workflow display ](./screenshots/ad-test-user-for-webadmin-and-dbadmin-created.png)
AD test users for WebAdmin and DBAdmin created
 


 ![Workflow display ](./screenshots/ad-test-users-for-webadmin-and-dbadmin-created-the-portal.png)
AD test users for WebAdmin and DBAdmin created the portal

•	I made adjustments to the contents of the second script named test_users.ps1 which is mean to validate role assignments.
•	It ran successfully when I sent the command.
 
 ![Workflow display ](./screenshots/getting-id-for-role-assignment.png)
Getting ID for role assignment


  ![Workflow display ](./screenshots/test-admins-added-for-role-assignment.png)
test admins added for role assignment
 

 ![Workflow display ](./screenshots/validation-in-process.png)
validation in process


![Workflow display ](./screenshots/validation-completed.png)
 validation completed
 
 ![Workflow display ](./screenshots/validation-password-displayed.png)
Validation password displayed


 
 ![Workflow display ](./screenshots/validation-for-dbadmin-user-on-the-portal.png)
Validation for DBAdmin user on the portal
 
 ![Workflow display ](./screenshots/validation-for-webadmin-user-on-the-portal.png)
Validation for WebAdmin user on the portal


