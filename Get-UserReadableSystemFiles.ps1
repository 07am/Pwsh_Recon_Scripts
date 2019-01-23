
# One-Liner to Enumerate Windows System32 Directory for Files owned by SYSTEM but readable by USERS.
##Author @07am
#

# This script will generate a decent amount of errors from denied access attempts. Use $ErrorActionPreference='SilentlyContinue' to suppress errors beforehand if ERRORS bother you. $ErrorActionPreference='Continue' to restore to default.

Function Get-UserReadableSystemFiles{
$ErrorActionPreference='SilentlyContinue';gci "$ENV:windir\system32" -recurse |? {$_.PSISContainer -ne 'true'} | %{get-acl $_.FullName} | ? {$_.AccessToString -like "*USERS*ALLOW*READ*" -and $_.Owner -like "*SYSTEM*"}  | ft path -autosize; $ErrorActionPreference='Continue'
}
