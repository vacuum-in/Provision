[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri "https://github.com/vacuum-in/Provision/raw/master/PackageManagement_x64.msi" -OutFile "C:\PackageManagement_x64.msi"
Invoke-Expression -Command "msiexec /i  C:\PackageManagement_x64.msi /qn"
powershell -Command "Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force; Install-Module -Name Azure -RequiredVersion 5.7.0"
