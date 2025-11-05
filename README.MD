This project demonstrates the automation of Identity and Access Management (IAM) in Microsoft Azure using Azure CLI and Bash scripting. It showcases how to programmatically create secure, role-based access controls for cloud infrastructure, following DevSecOps best practices.

Objectives

To automate the creation of Azure Resource Group, Virtual Network, and Subnets

To implement Azure Active Directory (AD) groups for access management

To assign role-based access control (RBAC) using the principle of least privilege

To create test users and validate permission assignments

To automate cleanup and resource removal

Implement CI/CD pipeline for continuous deployment

```
🏗️ Architecture
Azure Subscription
└── Resource Group (esther_rg) 
    └── Virtual Network (MyAppVnet) [10.0.0.0/16]   
        ├── Web Subnet (WebSubnet) [10.0.1.0/24]
        └── DB Subnet (DBSubnet) [10.0.2.0/24]

Azure Active Directory
├── WebAdmins Group (Reader role on Web Subnet)
    └── webadmin2
└── DBAdmins Group (Reader role on DB Subnet)
    └── dbadmin2
```

```
📁 Project Structure
IAM-Roles-Automation/

├── outputs/                     # contains Saved account IDs used for the project 
   └── resource_id.txt 
|── screenshots/                # Visual display of all tasks accomplished
    └──files
├── scripts/  
    ├── cleanup.sh
    ├── create_user.sh          # Creates Users in Azure AD  
    ├── resources.sh            # Creates resources in Azure 
    └── test_user.sh            # creates test users to the AD groups
├── document.md                 # Detailed step-by-step documentation of the project with screenshots 
└── README.md                    # Project overview and guide
└── .github/
    └── workflows/
        └── pipeline.yaml        # CI/CD automation with GitHub Actions
```

🛠️ Required Tools
Azure cloud platform
Azure CLI 
Bash Shell (Git Bash on Windows)
Powershell CLI
Azure Subscription with appropriate permissions
VS Code - code editor

Permissions for Azure account: 
Account must have owners role in the subscription
Account must have a global user permissions in order to create Azure AD users and groups
Permissions to assign RBAC roles
Verify Azure Login az login az account show

After Making Directory.

step 1: cd IAM Roles Automation

Step 2: create scripts and make Scripts Executable

Step 3: Set Your Subscription 

Find your subscription ID:

az account show --query id -o tsv

Step 4: Deploy Infrastructure

Creates:

Resource Group iam-role-automation in eastus region

Virtual Network MyWebVNet

Web Subnet Webubnet

DB Subnet dbSubnet

Step 5: Deploy IAM Configuration

Creates and Configure:

Azure AD groups: WebAdmins and DBAdmins

Test users: webadmin2 and dbadmin2

Role assignments (Reader on DB Subnet for DBAdmins)

Step 6: Validate Deployment

🧹 Cleanup Process

⚠️ WARNING: This will delete all resources created by this project.

Run:

./scripts/cleanup.sh

This script:

Removes role assignments

Removes users from groups

Deletes Azure AD users and groups

Deletes the Resource Group (including VNet and Subnets)


Project Information

Project: IAM Roles and Secure Access Automation (Group 4)

Technologies: Azure CLI, Bash, PowerShell, Azure AD, RBAC, GitHub Actions

Region: eastus

Date: October to November 2025


Additional Information

Azure CLI Documentation

Azure RBAC Documentation

Bash Scripting Guide

For full technical walkthrough, cleanup validation, and all screenshots — see docs/documentation.md.