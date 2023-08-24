# Depends on: install-module selenium

function auto-login{
    [CmdletBinding()]
    param([string]$Url,[STRING]$KeePass,[STRING]$KeePassEntry,[STRING]$IdLogin,[STRING]$IdPassword,[STRING]$IdButton)
    import-module "C:\Program Files\WindowsPowerShell\Modules\Selenium\3.0.1\Selenium.psd1"
    $Driver = Start-SeFirefox -ImplicitWait 15 -StartURL $url
    Enter-SeUrl $url -Driver $Driver 
    $Element = Find-SeElement -Driver $Driver -Id "$IdLogin"
    Send-SeKeys -Element $Element -Keys "$KeePassEntry"
    $Element = Find-SeElement -Driver $Driver -Id "$IdPassword"
    Send-SeKeys -Element $Element -Keys "$(get-secret -vault $KeePass -Name $KeePassEntry)"
    $Element = Find-SeElement -Driver $Driver -Id "$IdButton"
    Invoke-SeClick -Element $Element
}
