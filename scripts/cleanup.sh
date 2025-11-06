#!/bin/bash
set -euo pipefail

# ===============================
# Azure IAM Cleanup Script
# ===============================

# Configuration Variables
SUBSCRIPTION_ID="e8cc4b6b-df59-4d98-9916-0c7d7cbbd94e"
RESOURCE_GROUP="esther_rg"
VNET_NAME="MyAppVnet"
DB_SUBNET_NAME="DBSubnet"
DB_AD_GROUP_NAME="DBAdmins"
WEB_AD_GROUP_NAME="WebAdmin2"
WEB_TEST_USER="webadmin2@estygold226gmail.onmicrosoft.com"
DB_TEST_USER="dbadmin2@estygold226gmail.onmicrosoft.com"


print_message() {
  echo "=============================="
  echo "$1"
  echo "=============================="
}

print_message "Starting Azure IAM Cleanup..."

# Set active subscription
echo "Setting active subscription..."
az account set --subscription "$SUBSCRIPTION_ID"

print_message "Step 1: Remove Reader role from DBAdmins on DB subnet"

echo "Getting DB subnet resource ID..."
DB_SUBNET_ID=$(az network vnet subnet show \
  --resource-group "$RESOURCE_GROUP" \
  --vnet-name "$VNET_NAME" \
  --name "$DB_SUBNET_NAME" \
  --query id -o tsv 2>/dev/null || true)

if [[ -n "$DB_SUBNET_ID" && "$SKIP_ROLE_ASSIGN" == "false" ]]; then
  echo "Removing Reader role assignment for DBAdmins on DB subnet..."

  DB_GROUP_ID=$(az ad group show --group "$DB_AD_GROUP_NAME" --query id -o tsv 2>/dev/null || true)
  if [[ -n "$DB_GROUP_ID" ]]; then
    az role assignment delete \
      --assignee "$DB_GROUP_ID" \
      --role "Reader" \
      --scope "$DB_SUBNET_ID" \
      --only-show-errors || true

    echo "Reader role removed from DBAdmins successfully."
  else
    echo "DBAdmins group not found. Skipping role deletion..."
  fi
else
  echo "DB subnet not found or role cleanup skipped."
fi

print_message "Step 2: Remove users from groups and delete groups"

echo "Removing users from groups and deleting groups..."

# Remove and delete WebAdmin2 group
if az ad group show --group "$WEB_AD_GROUP_NAME" >/dev/null 2>&1; then
  WEB_USER_ID=$(az ad user show --id "$WEB_TEST_USER" --query id -o tsv 2>/dev/null || true)
  if [[ -n "$WEB_USER_ID" ]]; then
    az ad group member remove --group "$WEB_AD_GROUP_NAME" --member-id "$WEB_USER_ID" || true
  fi
  az ad group delete --group "$WEB_AD_GROUP_NAME" || true
  echo "WebAdmin2 group deleted."
else
  echo "WebAdmin2 group not found, skipping."
fi

# Remove and delete DBAdmins group
if az ad group show --group "$DB_AD_GROUP_NAME" >/dev/null 2>&1; then
  DB_USER_ID=$(az ad user show --id "$DB_TEST_USER" --query id -o tsv 2>/dev/null || true)
  if [[ -n "$DB_USER_ID" ]]; then
    az ad group member remove --group "$DB_AD_GROUP_NAME" --member-id "$DB_USER_ID" || true
  fi
  az ad group delete --group "$DB_AD_GROUP_NAME" || true
  echo "DBAdmins group deleted."
else
  echo "DBAdmins group not found, skipping."
fi


print_message "Step 3: Delete test users"

echo "Deleting test users..."
az ad user delete --id "$WEB_TEST_USER" || true
az ad user delete --id "$DB_TEST_USER" || true

print_message Step 4: Delete resource group including VNet and subnets

echo "Deleting resource group: $RESOURCE_GROUP"
az group delete --name "$RESOURCE_GROUP" --yes --no-wait || true

echo "CLEANUP COMPLETE."
