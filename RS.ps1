    param (
        [string]$siteName,
        [string]$connectionString,
        [string]$DBUserName,
        [string]$DBPassword,
          [string]$connectionStringName = "BookContext",
        [string]$ResourceGroupName
    )
    Import-Module WebAdministration
    #New-Item -Path "C:\" -Name TEstFile.txt -ItemType File -ErrorAction SilentlyContinue
    $DNS = (Get-AzureRmResourceGroupDeployment -ResourceGroupName $ResourceGroupName)
    $OUT = $DNS | Sort-Object -Property Timestamp -Descending | Select-Object -First 1
    $DNSname = $OUT.Outputs.sqldns.Value
    $DNSname  | Out-File -FilePath C:\TEstFile.txt -append
    
    $connectionString = $connectionString -replace "!DBTOREPLACE!", $DNSname  
    $connectionString = $connectionString -replace "!USERTOREPLACE!", $DBUserName
    $connectionString = $connectionString -replace "!PASSTOREPLACE!", $DBPassword
    $connectionString  | Out-File -FilePath C:\TEstFile.txt -append
    #$BooksContext
    #write-host "##vso[task.setvariable variable=BooksContext]$connectionString"

    $webPath = (Get-Website -Name $siteName).Physicalpath
    $webConfFile = "$webPath" + "\Web.config"

	$config = [xml](Get-Content -LiteralPath $webConfFile)

    $config.Configuration.connectionStrings

	$connStringElement = $config.SelectSingleNode("configuration/connectionStrings/add[@name='$connectionStringName']")

    if($connStringElement) 
    {

        $connStringElement.connectionString = $connectionString

    $config.Save($webConfFile)
    }

    else
    {
        Write-Error "Unable to locate connection string named: $connectionStringName"
    }


