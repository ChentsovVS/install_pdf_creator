$LocalDir = "c:\Distrib\pdfCreator"
$NetPath = "\\ilc-fileserv\e$\1-IT\GPO\INSTALL_PDF_creator"
$FileError = "$LocalDir\Error.txt"
$FileName1 = "pdf24-creator-10.0.12.msi" 
$FirstApp = "PDF24 Creator"

$ViewApp = Get-CimInstance -ClassName Win32_Product | where {$_.name -like "$FirstApp*"}

if ($null -ne $ViewApp)
{
    break
}

else 
{
    $ViewFiles = (get-ChildItem -Path $LocalDir\*).FullName 
    
    if ($null -eq $ViewFiles) 
    {
        Copy-Item $NetPath\* -Filter "*.msi" -Destination $LocalDir
    }

    if ($null -eq $ViewAPP)
    {
        $InstallStatus = invoke-CimMethod -ClassName Win32_Product -MethodName Install -Arguments @{PackageLocation="$LocalDir\$fileName1"}
        if ($InstallStatus.ReturnValue -ne 0)
        {
            $InstallStatus | Out-File -FilePath $FileError 
        } 
    }
}