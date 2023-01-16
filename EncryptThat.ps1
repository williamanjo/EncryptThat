Add-Type -AssemblyName System.Windows.Forms
$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ 
    
    Filter = 'Arquivo Fonte Configuration (*.config)|*.config'
    Multiselect = 'false'
    CheckFileExists = 'true'
 }
$dialogResult = $FileBrowser.ShowDialog()

if($dialogResult -eq "OK"){

    $filename = $FileBrowser.SafeFileName
    $folderPath = Split-Path -Path $FileBrowser.FileName

    
    Write-Host "Encrypt That (E)  | Decrypt That (D)"
    $response = ''
    while((($response.ToUpper() -cne "D")  -And  ($response.ToUpper() -cne "E"))){
        write-host (($response.ToUpper() -cne "D")  -And  ($response.ToUpper() -cne "E"))
        $response =  Read-Host 
    }
    if($response -eq 'e' -or $response -eq 'E'){

        Rename-Item -Path "$($FileBrowser.FileName)" -NewName "Web.config"
        Invoke-Expression "$($Env:windir)\Microsoft.NET\Framework\v4.0.30319\aspnet_regiis -pef 'connectionStrings' '$($folderPath)'"
        Rename-Item -Path "$($folderPath)\Web.config" -NewName $filename

    }elseif($response[0] -eq 'D' -or $response[0] -eq 'D'){

        Rename-Item -Path "$($FileBrowser.FileName)" -NewName "Web.config"
        Invoke-Expression "$($Env:windir)\Microsoft.NET\Framework\v4.0.30319\aspnet_regiis -pdf 'connectionStrings' '$($folderPath)'"
        Rename-Item -Path "$($folderPath)\Web.config" -NewName $filename

    }else{

        Rename-Item -Path "$($folderPath)\Web.config" -NewName $filename
        break
    }
     
}
