#!bin/bash

#déclaration du fichier contenant les raccourcis des favoris comme une variable globale.
FAV=$HOME/.favoris_bash

if [ ! -f $FAV ];
then
touch $FAV
echo "Dossier de favoris crée."
fi


#première fonction permettant d'ajouter le repertoire courant comme favori
function S {
# on vérifie que le nom d'un raccourci est bien passé en paramètre.
if [ $# -eq 0 ];
	then 
	echo " utilisation de S impossible merci de passer un fichier en paramètre."
else 	
#création de 2 variables locales à la fonction.
#La variable contenant le nom du raccourci passé en paramètre 
local nomfichier=$1
#La variable contenant le chemin du repertoire ou le script est executé.
local chemin=$(pwd)
#troisième variable qui contient le chemin du fichier courant si le raccourci existe déjà
local testexistence=$(grep "^$nomfichier" $FAV)
# test pour voir si la variable testexistence est non vide signifiant que le raccourci existe déjà
if [ -n "$testexistence" ];
then 
echo "le raccourci existe déja sous le même nom"
else
#on ajoute à la fin du fichier contenant les favoris une nouvelle ligne avec le nouveau raccourci.
echo "$nomfichier->$chemin" >> "$FAV"
#on informe l'utilisateur que l'opération est un succès.
echo "Le répertoire $chemin est sauvegardé dans vos favoris."
echo "-> raccourci : $nomfichier."
fi
fi
}

#fonction permettant de changer de répertoire.
function C {
#on vérifie que le nom d'un raccourci est bien passé en paramètre.
	if [ $# -eq 0 ];
	then 
	echo " utilisation de C impossible merci de passer un fichier en paramètre."
	else 	
#création de 2 variables locales à la fonction.
#La variable contenant le nom du raccourci passé en paramètre 
local nomrepertoire=$1
#la seconde qui contient le chemin que l'on va passer dans la commande cd
#pour construire cette variable on utilise dans un premier temps la fonction grep pour trouver le chemin du raccourci et à l'aide d'un pipe on utlise sed sur la sortie de la commande pour ne garder que la deuxième partie de la ligne.
local chemin=$(grep "^$nomrepertoire" $FAV | sed "s/.*->//")
#on verifie que la variable chemin n'est pas vide.
if [ -n "$chemin" ];
then
#si elle n'est pas vide on change de répertoire.
cd "$chemin"
echo "le changement de répertoire a été effectué vous êtes maintenant dans $chemin."
else 
# si elle est vide on informe l'utilisateur que son raccourci passé en paramètre n'existe pas.
echo "ce répertoire favori n'existe pas"
fi
fi
}


#fonction R permettant de supprimer un raccourci.
function R {
#on vérifie que le nom d'un raccourci est bien passé en paramètre.
if [ $# -eq 0 ];
then 
echo " utilisation de R impossible merci de passer un fichier en paramètre."
else 
# on crée une variable contenant le nom du raccourci
nomrepertoire=$1 
#grace à la commande sed, on suppprime la ligne contenant ce raccourci, on utilise l'option -i pour modifier le fichier d'entréedirectement.
sed -i "/^$nomrepertoire/d" $FAV
echo "Le favori $nomrepertoire a été supprimé."
fi
}

#fonction permettant d'afficher la liste des favoris.
function L {
echo "Liste de vos favoris :"
#on affiche simplement le fichier contenant la liste des favoris.
cat $FAV
}




