#!/bin/bash


#variables
RESOURCE_GROUP="esther_rg"
 LOCATION="eastus" 
VNET_NAME="MyAppVNet" 
VNET_ADDRESS="10.0.0.0/16" 
WEB_SUBNET_NAME="WebSubnet" 
WEB_SUBNET_ADDRESS="10.0.1.0/24"
 DB_SUBNET_NAME="DBSubnet" 
DB_SUBNET_ADDRESS="10.0.2.0/24"
WEB_GROUP_NAME="WebAdmins"
DB_GROUP_NAME="DBAdmins"

print_message() {
    echo "================================"
    echo "$1"
    echo "================================"
}

#check if resouce group exist before creating

check_resource_group() {
    if az group show --name $RESOURCE_GROUP &> /dev/null; then
        print_message "Resource group $RESOURCE_GROUP already exists"
        return 0
    else
        return 1
    fi
}
 print_message "creating resources in Task 1 - rg, vnet and subnet"

# Step 1: Create Resource Group
print_message "Step 1: Creating Resource Group"
if ! check_resource_group; then
    az group create \
        --name $RESOURCE_GROUP \
        --location $LOCATION \
        --tags Environment=Development Project=WebApp
    echo "Resource group created successfully"
else
    echo "Using existing resource group"
fi

# Step 2: Create Virtual Network
print_message "Step 2: Creating Virtual Network"
az network vnet create \
    --resource-group $RESOURCE_GROUP \
    --name $VNET_NAME \
    --address-prefix $VNET_ADDRESS \
    --location $LOCATION

echo "Virtual Network created: $VNET_NAME"

# Step 3: Create Web Subnet
print_message "Step 3: Creating Web Subnet"
az network vnet subnet create \
    --resource-group $RESOURCE_GROUP \
    --vnet-name $VNET_NAME \
    --name $WEB_SUBNET_NAME \
    --address-prefixes $WEB_SUBNET_ADDRESS

echo "Web Subnet created: $WEB_SUBNET_NAME ($WEB_SUBNET_ADDRESS)"

# Step 4: Create DB Subnet
print_message "Step 4: Creating DB Subnet"
az network vnet subnet create \
    --resource-group $RESOURCE_GROUP \
    --vnet-name $VNET_NAME \
    --name $DB_SUBNET_NAME \
    --address-prefixes $DB_SUBNET_ADDRESS

echo "DB Subnet created: $DB_SUBNET_NAME ($DB_SUBNET_ADDRESS)"

# Display summary
print_message "ResourceSetup Complete!"
echo "Resource Group: $RESOURCE_GROUP"
echo "Virtual Network: $VNET_NAME ($VNET_ADDRESS)"
echo "Web Subnet: $WEB_SUBNET_NAME ($WEB_SUBNET_ADDRESS)"
echo "DB Subnet: $DB_SUBNET_NAME ($DB_SUBNET_ADDRESS)"

# Export resource IDs for use in other scripts
DB_SUBNET_ID=$(az network vnet subnet show \
    --resource-group $RESOURCE_GROUP \
    --vnet-name $VNET_NAME \
    --name $DB_SUBNET_NAME \
    --query id -o tsv)

echo "DB Subnet ID: $DB_SUBNET_ID"

set -e



print_message() {
    echo "================================"
    echo "$1"
    echo "================================"
}

 #check if group exists
check_group_exists() {
    local group_name=$1
    if az ad group show --group "$group_name" &> /dev/null; then
        return 0
    else
        return 1
    fi
}
# Step 1: Create Azure AD Groups
print_message "Task 2: Creating Azure AD Groups"

# Create WebAdmins group
if ! check_group_exists "$WEB_GROUP_NAME"; then
    WEB_GROUP_ID=$(az ad group create \
        --display-name $WEB_GROUP_NAME \
        --mail-nickname $WEB_GROUP_NAME \
        --description "Administrators for Web Subnet resources" \
        --query id -o tsv)
    echo "Created group: $WEB_GROUP_NAME"
else
    WEB_GROUP_ID=$(az ad group show --group "$WEB_GROUP_NAME" --query id -o tsv)
    echo "Group already exists: $WEB_GROUP_NAME"
fi

# Create DBAdmins group
if ! check_group_exists "$DB_GROUP_NAME"; then
    DB_GROUP_ID=$(az ad group create \
        --display-name $DB_GROUP_NAME \
        --mail-nickname $DB_GROUP_NAME \
        --description "Administrators for Database Subnet resources" \
        --query id -o tsv)
    echo "Created group: $DB_GROUP_NAME"
else
    DB_GROUP_ID=$(az ad group show --group "$DB_GROUP_NAME" --query id -o tsv)
    echo "Group already exists: $DB_GROUP_NAME"
fi
