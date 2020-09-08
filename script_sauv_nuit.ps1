#Script sauvegarde de nuit des postes clients

Try {
#Sélection des ordinateurs avec Windows 10 dessus.
$Names = Get-ADComputer -Filter { OperatingSystem -Like '*Windows*10*' } -Properties OperatingSystem | Select -Expand Name

}

Catch{
Write-Host "Impossible de trouver les ordinateurs"
exit 1
}

#Boucle de copie des dossiers utilisateurs
ForEach ($Name in $Names)
{

xcopy /S /I \\$Name\C$\Users C:\SAVE\$Name /Y >>C:\SAVE\LOG\sauvegarde.log


}


