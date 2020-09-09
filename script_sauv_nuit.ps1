#Script sauvegarde de nuit des postes clients.

Try {
#Sélection des ordinateurs avec Windows 10 dessus.
$Names = Get-ADComputer -Filter { OperatingSystem -Like '*Windows*10*' } -Properties OperatingSystem | Select -Expand Name

}

Catch{
Write-Host "Impossible de trouver les ordinateurs"
exit 1
}

#Boucle de copie des dossiers utilisateurs si l'ordi est allumé.

ForEach ($Name in $Names)
{
If (Test-Connection $Name -Quiet) { 
	xcopy /S /I \\$Name\C$\Users C:\SAVE\$Name /Y >>C:\SAVE\LOG\sauvegarde.log
}
Else{
	Write-EventLog -LogName Application -Source "Script svg nuit" -EntryType Error -EventId 1 -Message "$Name non trouvé"
}

}