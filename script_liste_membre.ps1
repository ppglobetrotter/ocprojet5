#Script liste membres d'un groupe

#Cr�ation de la variable du nom de groupe
$nom_grp = Read-Host "Nom du groupe"

#S�lection du nom des membres du groupe.
Try {
$data = Get-ADGroupMember -Identity $nom_grp | Select-Object name
}

# En cas d'erreur lors de la saisie du nom du groupe
Catch {
Write-Host "Nom du groupe inexistant"
exit 1
}

#Export des donn�es dans un fichier
$data | Export-Csv C:\Scripts\Liste_membres_$nom_grp.csv -NoTypeInformation -Encoding UTF8
Write-Host "Liste cr��e dans C:\Scripts"