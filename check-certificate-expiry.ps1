function Check-Certificate-Expiry($PathToCert){
$PathToCert | ForEach-Object { 
            if (($_.Subject) -like "*my condition or name*"){
                if (!($_.Verify())){
                    write-output  "The following certificate is expired :`n`n `n $_"
                }
            }
        }
}
