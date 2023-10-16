$ConfigFile = Get-Content "Certificate.ini" | ConvertFrom-StringData

$CommonName = $ConfigFile.CommonName
$Organization = $ConfigFile.Organization
$Country = $ConfigFile.Country
$FriendlyName = $ConfigFile.FriendlyName

$CertPassword = Read-Host 'Enter Export Password' -AsSecureString

$cert = New-SelfSignedCertificate `
    -Type CodeSigningCert `
    -Subject "CN=$CommonName, O=$Organization, C=$Country" `
    -FriendlyName "$FriendlyName" `
    -CertStoreLocation "Cert:\CurrentUser\My" `
    -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.3", "2.5.29.19={text}")

Write-Host "Export Thumbprint: $($cert.Thumbprint)"

Export-PfxCertificate -Cert "cert:\CurrentUser\My\$($cert.Thumbprint)" -FilePath "Certificate.pfx" -Password $CertPassword
