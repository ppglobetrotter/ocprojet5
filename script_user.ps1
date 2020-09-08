#Script de cr�ation d'un nouvel utilisateur et de son dossier partag�.

#Cr�ation de la variable $pr�nom
$prenom = Read-Host "Pr�nom du nouvel utilisateur" 
	
#Cr�ation de la variable $nom
$nom = Read-Host "NOM du nouvel utilisateur"
		
#Cr�ation automatique de la variable $nom_complet
$nom_complet = "$($prenom) $($nom)"

#Cr�ation de la variable $login
$login = Read-Host "Nom du compte du nouvel utilisateur"
	
#Cr�ation de la variable $mdp
$mdp = Read-Host "Mot de passe du nouvel utilisateur (8 caract�res mini)"
		
#Cr�ation de la variable $groupe
$groupe = Read-Host "Nom du groupe du nouvel utilisateur"	

Try {
# Cr�ation de l'utilsateur
New-ADUser -Name $nom_complet -GivenName $prenom -Surname $nom -SamAccountName $login -UserPrincipalName $login@acme.fr -AccountPassword (ConvertTo-SecureString -AsPlainText $mdp -Force) -ChangePasswordAtLogon $true -Enabled $true
#Cr�ation du dossier
New-Item -Path G:\$groupe\$prenom -ItemType Directory
#Partage du dossier
New-SmbShare -Name $prenom -Path G:\$groupe\$prenom -FullAccess Administrateurs
#Configuration des droits de partage
Grant-SmbShareAccess -Name $prenom -AccountName "$login" -AccessRight Change -Force
}

Catch {
#Message en cas d'erreur
Write-Host "Erreur lors de la cr�ation de l'utilisateur."
exit 1
}

#Message affich� � la fin du script
Write-Host "L'utilisateur $nom_complet a bien �t� cr�� ainsi que son dossier partag�."
