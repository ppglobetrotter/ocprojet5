#Script récupération de la liste des groupes dont un utilisateur est membre.

#Saisie du nom d'utilisateur
$nom_user = Read-Host "Nom de l'utilisateur"

#Récupération de la liste des groupes
Try {
$data = Get-ADPrincipalGroupMembership $nom_user | select name
}

#Message en cas d'erreur
Catch {
Write-Host "Nom d'utilisateur inconnu"
exit 1
}

#Export de la liste et affiché le message de destination
$data | Export-Csv C:\Scripts\Liste_groupe_$nom_user.csv -NoTypeInformation -Encoding UTF8
Write-Host "Liste créée dans C:\Scripts"