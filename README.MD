AzURE IAM ROLES AND ACCESS AUTOMATION (CLI/Bash)
This project provides a set of Bash scripts utilizing the Azure CLI to automate the setup of essential infrastructure and secure Identity and Access Controls (IAM) within Azure. 
The primary focus is on implementing Azure RBAC (Role-Based Access Control) at a granular level to enforce the principle of least privilege.

OBJECTIVE
Automate the end-to-end setup of secure identity and access controls using Azure CLI and Bash scripting. 
This includes infrastructure provisioning and precise role assignment to Azure Active Directory (Azure AD) groups.

FEATURES
Infrastructure as Script: Full provisioning of network resources (Resource Group, VNet, Subnets) via a single script.

Automated Azure AD Management: Programmatic creation of security groups (WebAdmin, DBAdmin).

Granular RBAC Enforcement: Assigns built-in Azure Roles to AD groups at the subnet level to strictly control access to specific network resources.

Validation: Includes steps to verify the role assignments and test user access.

hese instructions will get the project running and deployed in your Azure environment.

PRE-REQUISITES
Azure Subscription: An active Azure account.

Azure CLI: Installed locally (or run in Azure Cloud Shell).

Bash Environment: A Linux/macOS environment or Windows Subsystem for Linux (WSL).

Powershell Environment, configured.

Permissions: You must have permissions to create Resource Groups, Virtual Networks, and manage Azure AD Groups/Role Assignments (e.g., Owner or User Access Administrator role).

INSTALLATION AND DEPLOYMENT
Clone the repository:

Bash

git clone [YOUR_REPO_URL]
cd azure-rbac-automation
Authenticate with Azure:

Bash

az login
(set traget subscription)
az account set --subscription "Your-Subscription-ID"
Execute the main deployment script:

Bash
(review script and execute)
bash deploy.sh

