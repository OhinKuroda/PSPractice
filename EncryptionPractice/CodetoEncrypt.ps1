$cert = get-childitem -path Cert:\CurrentUser\My -CodeSigningCert
Set-AuthenticodeSignature -FilePath C:\Scripts\EncryptDemo.ps1 -certificate $cert

