<#
.DESCRIPTION
Installer le module KeePass pour powershell ou recuperer le mdp d'une entree du keepass
#>
function Install-KeePass{
    [CmdletBinding()]
    param([string]$KeePass,[STRING]$KeePath,[String]$KeyPath)
    Install-Module -Name Microsoft.PowerShell.SecretManagement 
    Install-Module -Name Microsoft.PowerShell.SecretStore
    Install-Module SecretManagement.KeePass

    Register-SecretVault -Name "$KeePass" -ModuleName "SecretManagement.Keepass" -VaultParameters @{
        Path = "$KeePath"
        UseMasterPassword = $true
        KeyPath= "$KeyPath"
    }
}


function Get-CredKeePass{
    [CmdletBinding()]
    param([string]$KeePass,[STRING]$KeePassEntry)
    return get-Secret -vault "$KeePass" -name "$KeePassEntry" 
}
