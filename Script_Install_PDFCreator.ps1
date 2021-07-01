# инициализируем переменные 
$LocalDir = "c:\Distrib\pdfCreator"
$NetPath = "\\ilc-fileserv\e$\1-IT\GPO\INSTALL_PDF_creator"
$FileError = "$LocalDir\Error.txt"
$FileName1 = "pdf24-creator-10.0.12.msi" 
$FirstApp = "PDF24 Creator"

# Проверяем установленно ли ПО на ПК 
$ViewApp = Get-CimInstance -ClassName Win32_Product | where {$_.name -like "$FirstApp*"}

# Если установленно - тогда ничего не делаем 
if ($null -ne $ViewApp)
{
    break
}

# Если не установленно - проверяем есть ли установочные файлы
else 
{
    $ViewFiles = (get-ChildItem -Path $LocalDir\*).FullName 
    
    # Если файлов нет - тогда скачиваем 
    if ($null -eq $ViewFiles) 
    {
        Copy-Item $NetPath\* -Filter "*.msi" -Destination $LocalDir
    }

    # Если файлы присутствуют, тогда устанавливаем ПО.
    if ($null -eq $ViewAPP)
    {
        $InstallStatus = invoke-CimMethod -ClassName Win32_Product -MethodName Install -Arguments @{PackageLocation="$LocalDir\$fileName1"}
        
        # Если во время установки вернулся не нулевой код (т.е. не установилась ПО) - тогда записываем его в файл 
        if ($InstallStatus.ReturnValue -ne 0)
        {
            $InstallStatus | Out-File -FilePath $FileError 
        } 
    }
}