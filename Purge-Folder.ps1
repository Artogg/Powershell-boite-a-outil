function Purge-Folder{
    [CmdletBinding()]
    param([string]$Directory,[INT]$Delai)

    try{
        return (Get-ChildItem -Path "$Directory" -recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-$Delai))} | Remove-Item -force -recurse -ErrorAction Stop)
    } catch {
        Write-output "Impossible de purger le dossier $Directory."
    }
}
