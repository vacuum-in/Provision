[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri "http://github.com/vacuum-in/DependenciesTest/raw/master/DB/Books.dacpac" -OutFile "C:\PackageManagement_x64.msi"
C:\PackageManagement_x64.msi /quite
