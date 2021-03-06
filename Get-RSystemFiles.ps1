# Get-RSystemFiles.ps1
# One-Liner to Enumerate Windows System32 Directory for Files owned by SYSTEM but readable by USERS.
##Author @07am
#

# This script will generate a decent amount of errors from denied access attempts. Uses $ErrorActionPreference='SilentlyContinue' to suppress errors beforehand and $ErrorActionPreference='Continue' to restore to default after.

Function Get-RSystemFiles{
gci "$ENV:windir\system32" -File |? {$_.PSISContainer -ne 'true'} | %{get-acl $_.FullName} | ? {$_.AccessToString -like "*USERS*ALLOW*READ*" -and $_.Owner -like "*SYSTEM*"}  | ft path; Write-Output "Module Complete."
}
