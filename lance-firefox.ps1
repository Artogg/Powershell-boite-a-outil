<#
.DESCRIPTION
Script pour lancer plusieurs tabs en simultané.
Pratique dans un planificateur de tâches au démarrage du PC.
#>

# Liste des sites à lancer
$urls = @("https://monsite1","http://monsite2")

# On lance les tabs
foreach($url in $urls){
    start "C:\Program Files (x86)\Mozilla Firefox\firefox.exe" -ArgumentList @($url)
    Start-Sleep -Seconds 1
}
