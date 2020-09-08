#Script de création d'un nouvel utilisateur et de son dossier partagé.

#Création de la variable $prénom
$prenom = Read-Host "Prénom du nouvel utilisateur" 
	
#Création de la variable $nom
$nom = Read-Host "NOM du nouvel utilisateur"
		
#Création automatique de la variable $nom_complet
$nom_complet = "$($prenom) $($nom)"

#Création de la variable $login
$login = Read-Host "Nom du compte du nouvel utilisateur"
	
#Création de la variable $mdp
$mdp = Read-Host "Mot de passe du nouvel utilisateur (8 caractères mini)"
		
#Création de la variable $groupe
$groupe = Read-Host "Nom du groupe du nouvel utilisateur"	

Try {
# Création de l'utilsateur
New-ADUser -Name $nom_complet -GivenName $prenom -Surname $nom -SamAccountName $login -UserPrincipalName $login@acme.fr -AccountPassword (ConvertTo-SecureString -AsPlainText $mdp -Force) -ChangePasswordAtLogon $true -Enabled $true
#Création du dossier
New-Item -Path G:\$groupe\$prenom -ItemType Directory
#Partage du dossier
New-SmbShare -Name $prenom -Path G:\$groupe\$prenom -FullAccess Administrateurs
#Configuration des droits de partage
Grant-SmbShareAccess -Name $prenom -AccountName "$login" -AccessRight Change -Force
}

Catch {
#Message en cas d'erreur
Write-Host "Erreur lors de la création de l'utilisateur."
exit 1
}

#Message affiché à la fin du script
Write-Host "L'utilisateur $nom_complet a bien été créé ainsi que son dossier partagé."
