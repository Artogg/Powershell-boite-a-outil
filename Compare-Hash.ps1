function Compare-Hash-file{
    [CmdletBinding()]
    param([string]$File1,[String]$File2)
    if((Test-Path $File1) -and (Test-Path $file2)){
        $HashFile1=  Get-FileHash -Path $File1 
        $HashFile2 =  Get-FileHash -Path $File2
        if ($HashFile1.hash -ne $HashFile2.hash){
            return write-output "Les hash des deux fichiers sont differents."
        } else {
            return write-output "Les hashs des deux fichiers  sont identiques."
        }
    }
}

function Compare-Hash-Directory{
    [CmdletBinding()]
    param([string]$Directory1,[String]$Directory2)
    if((Test-Path $Directory1) -and (Test-Path $Directory2)){
        $HashDirectory1=  Get-ChildItem -File -Recurse $Directory1 | ForEach-Object { Get-FileHash -Path $_.FullName }
        $HashDirectory2 =  Get-ChildItem -File -Recurse $Directory2 | ForEach-Object { Get-FileHash -Path $_.FullName }
        if (Compare-Object -ReferenceObject $HashDirectory1.Hash  -DifferenceObject $HashDirectory2.Hash){
            return write-output "Les hash des deux repertoires sont differents."
        } else {
            return write-output "Les hashs des deux repertoires sont identiques."
        }
    }
}

