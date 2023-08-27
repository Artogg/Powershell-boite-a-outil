function Timestamp{
    return get-date -Format "yyyyMMdd HH:mm:ss"
}

# Variable a customiser
$speedlimit=3000
$FichierLogsDuJour=""
$Winscpdll=""

# La dll et le exe doivent etre au meme endroit
Add-Type -Path $Winscpdll

# Configurer les options de session
$sessionOptions = New-Object WinSCP.SessionOptions -Property @{
    Protocol = [WinSCP.Protocol]::Ftp
    HostName = ""
    UserName = ""
    Password = ""
    FtpSecure = [WinSCP.FtpSecure]::Implicit
    TlsHostCertificateFingerprint = <certificat du serveur ftps>
    FtpMode = [WinSCP.FtpMode]::Active
}


$session = New-Object WinSCP.Session

try {
    # On teste de se connecter au serveur ftps
    $session.Open($sessionOptions)
    Add-Content -Path $FichierLogsDuJour "$(Timestamp) - [INFO] Session etablie avec le serveur FTPS."

     #Option du transfert avec reprise en mode Binary
    $transferOptions = New-Object WinSCP.TransferOptions
    $transferOptions.TransferMode = [WinSCP.TransferMode]::Binary
    $transferOptions.ResumeSupport.State = [WinSCP.TransferResumeSupportState]::On

    # Limite vitesse en Ko/s
    $transferOptions.SpeedLimit = $speedlimit
    # Si le serveur ftps est joignable, on tente l'envoi 
    try{
        # Parametre True pour suppression du fichier source a la fin de la copie, sinon $false
        $transferResult = $session.PutFiles("<monfichier>","/<cheminvirtuelsurleserveurftps>",$false,$TransferOptions)
        $transferResult.check()
    } catch{
        Add-Content -Path $FichierLogsDuJour "$(Timestamp) - [ERREUR] Erreur dans le transfert FTPS."
    }
# S'il y a une erreur de connexion au serveur ftps
} catch {
    Add-Content -Path $FichierLogsDuJour "$(Timestamp) - [ERREUR] Impossible de joindre le serveur FTPS."
    $session.Dispose()
    exit
# On ferme la session proprement
} finally{
    Add-Content -Path $FichierLogsDuJour "$(Timestamp) - [INFO] Fermeture de la session avec le serveur FTPS."
    $session.Dispose()
}

