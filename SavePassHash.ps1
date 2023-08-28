<#
.DESCRIPTION
Hasher un mot de passe dans un fichier.
Ne peut être déchiffrer que par l'user qui a fait le hash.
#>

function Set-HashSecret{
    [CmdletBinding()]
    param([string]$Pass,[STRING]$File)
    "$Pass" | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString | Out-File "$File"
}

function Get-HashSecret{
    [CmdletBinding()]
    param([STRING]$File)
    if(test-path $File){
        $EncryptedPass = Get-Content $File | ConvertTo-SecureString 
        $Temp = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($EncryptedPass)
        return $DecryptedPass = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($Temp)
    } else {
        ##### a customiser ####
}
