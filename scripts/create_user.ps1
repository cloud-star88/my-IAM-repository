# ============================================
# Create Test Users in Azure AD
# ============================================

$ErrorActionPreference = "Stop"

# Your domain
$domainName = "estygold226hotmail012.onmicrosoft.com"

Write-Host "Creating users in domain: $domainName" -ForegroundColor Cyan

# Password for both users
$password = ConvertTo-SecureString "SecurePass123!@#" -AsPlainText -Force

# Create webadmin2
Write-Host "`nCreating webadmin2..." -ForegroundColor Yellow
$webAdminUPN = "webadmin2@$domainName"

try {
    $webUser = New-AzADUser `
        -DisplayName "web admin 2" `
        -UserPrincipalName $webAdminUPN `
        -Password $password `
        -MailNickname "webadmin2" `
        -AccountEnabled $true
    
    Write-Host "Created: $webAdminUPN" -ForegroundColor Green
    Write-Host "  Object ID: $($webUser.Id)" -ForegroundColor Cyan
} catch {
    Write-Host "Failed to create webadmin2: $_" -ForegroundColor Red
}

# Create dbadmin2
Write-Host "`nCreating dbadmin2..." -ForegroundColor Yellow
$dbAdminUPN = "dbadmin2@$domainName"

try {
    $dbUser = New-AzADUser `
        -DisplayName "db admin 2" `
        -UserPrincipalName $dbAdminUPN `
        -Password $password `
        -MailNickname "dbadmin2" `
        -AccountEnabled $true
    
    Write-Host "Created: $dbAdminUPN" -ForegroundColor Green
    Write-Host "  Object ID: $($dbUser.Id)" -ForegroundColor Cyan
} catch {
    Write-Host "Failed to create dbadmin2: $_" -ForegroundColor Red
}

Write-Host "`n========================================" -ForegroundColor Green
Write-Host "Users Created!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green

Write-Host "`nCredentials:" -ForegroundColor Yellow
Write-Host "Username: webadmin2@$domainName"
Write-Host "Username: dbadmin2@$domainName"
Write-Host "Password: SecurePass123!@#"

Write-Host "`nNext: Run the test_user groups script to add them to groups" -ForegroundColor Cyan