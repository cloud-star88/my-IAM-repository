#----------------------------------
# Add test users to AD groups 
#---------------------------------

# Stop on errors
$ErrorActionPreference = "Stop"

# variables
$domainName = "estygold226hotmail012.onmicrosoft.com"
$WebGroupName = "WebAdmins"
$DBGroupName = "DBAdmins"

Write-Host "Using domain: $domainName" -ForegroundColor Cyan

# User credentials
$webAdminUPN = "webadmin2@$domainName"
$dbAdminUPN = "dbadmin2@$domainName"
$password = ConvertTo-SecureString "SecurePass123!@#" -AsPlainText -Force

# Create webadmin2
Write-Host "`nCreating/Getting webadmin2..." -ForegroundColor Yellow
try {
    $webUser = Get-AzADUser -UserPrincipalName $webAdminUPN -ErrorAction Stop
    Write-Host "User already exists: $webAdminUPN" -ForegroundColor Yellow
} catch {
    Write-Host "User not found, creating..." -ForegroundColor Cyan
    $webUser = New-AzADUser `
        -DisplayName "web admin 2" `
        -UserPrincipalName $webAdminUPN `
        -Password $password `
        -MailNickname "webadmin2" `
        -AccountEnabled $true
    Write-Host "Created: $webAdminUPN" -ForegroundColor Green
}

# Create dbadmin2
Write-Host "`nCreating/Getting dbadmin2..." -ForegroundColor Yellow
try {
    $dbUser = Get-AzADUser -UserPrincipalName $dbAdminUPN -ErrorAction Stop
    Write-Host "User already exists: $dbAdminUPN" -ForegroundColor Yellow
} catch {
    Write-Host "User not found, creating..." -ForegroundColor Cyan
    $dbUser = New-AzADUser `
        -DisplayName "db admin 2" `
        -UserPrincipalName $dbAdminUPN `
        -Password $password `
        -MailNickname "dbadmin2" `
        -AccountEnabled $true
    Write-Host "Created: $dbAdminUPN" -ForegroundColor Green
}

# Get user IDs
$webUserId = if ($webUser.Id) { $webUser.Id } else { $webUser.ObjectId }
$dbUserId = if ($dbUser.Id) { $dbUser.Id } else { $dbUser.ObjectId }

Write-Host "`nUser IDs:" -ForegroundColor Cyan
Write-Host "webadmin2 ID: $webUserId"
Write-Host "dbadmin2 ID: $dbUserId"

# Get groups
Write-Host "`nGetting groups..." -ForegroundColor Yellow
$webGroup = Get-AzADGroup -DisplayName $WebGroupName
$dbGroup = Get-AzADGroup -DisplayName $DBGroupName

$webGroupId = if ($webGroup.Id) { $webGroup.Id } else { $webGroup.ObjectId }
$dbGroupId = if ($dbGroup.Id) { $dbGroup.Id } else { $dbGroup.ObjectId }

Write-Host "WebAdmins ID: $webGroupId"
Write-Host "DBAdmins ID: $dbGroupId"

# Add to groups
Write-Host "`nAdding users to groups..." -ForegroundColor Yellow

# Add webadmin2 to WebAdmins
$webMembers = Get-AzADGroupMember -GroupObjectId $webGroupId
$webMemberIds = $webMembers | ForEach-Object { if ($.Id) { $.Id } else { $_.ObjectId } }

if ($webMemberIds -contains $webUserId) {
    Write-Host "webadmin2 already in WebAdmins" -ForegroundColor Yellow
} else {
    Add-AzADGroupMember -TargetGroupObjectId $webGroupId -MemberObjectId $webUserId
    Write-Host "Added webadmin2 to WebAdmins" -ForegroundColor Green
}

# Add dbadmin2 to DBAdmins
$dbMembers = Get-AzADGroupMember -GroupObjectId $dbGroupId
$dbMemberIds = $dbMembers | ForEach-Object { if ($.Id) { $.Id } else { $_.ObjectId } }

if ($dbMemberIds -contains $dbUserId) {
    Write-Host "dbadmin2 already in DBAdmins" -ForegroundColor Yellow
} else {
    Add-AzADGroupMember -TargetGroupObjectId $dbGroupId -MemberObjectId $dbUserId
    Write-Host "Added dbadmin2 to DBAdmins" -ForegroundColor Green
}

# Validate
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "VALIDATION" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "`nWebAdmins Members:" -ForegroundColor Yellow
Get-AzADGroupMember -GroupObjectId $webGroupId | Format-Table DisplayName, UserPrincipalName

Write-Host "DBAdmins Members:" -ForegroundColor Yellow
Get-AzADGroupMember -GroupObjectId $dbGroupId | Format-Table DisplayName, UserPrincipalName

Write-Host "DBAdmins Role Assignments:" -ForegroundColor Yellow
Get-AzRoleAssignment -ObjectId $dbGroupId | Format-Table DisplayName, RoleDefinitionName, Scope

Write-Host "`n========================================" -ForegroundColor Green
Write-Host "COMPLETED!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green

Write-Host "`nTest User Credentials:" -ForegroundColor Cyan
Write-Host "Username: webadmin2@$domainName"
Write-Host "Username: dbadmin2@$domainName"
Write-Host "Password: SecurePass123!@#" -ForegroundColor Yellow