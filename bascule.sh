#/bin/bash

function echoer() { echo "$@" 1>&2 ; }
function die() { echoer "$@" ; exit 1 ;}

function px_ask_yn() {
        echo -en "$1 [y/n] ? "
        read -r reponse
        if [ "$reponse" == "y" -o "$reponse" == "Y" ]; then
                return 0
        else
                if [ "${2}" == "die" ] ; then
                        exit 1
                fi
                return 1
        fi
}

function get_num() {
        echo -en "Veuillez saisir un numéro de telephone : "
        read -r numero
}

function consulter() {
        fichier=/etc/nagios/objects/commands.cfg
        num=`sudo grep "[0][6][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]$" $fichier | awk '{print $NF}'`
        echo "Le numéro d'astreinte actuel est : $num"
}

function modifier() {
        get_num
        fichier=/etc/nagios/objects/commands.cfg
        num=`sudo grep "[0][6][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]$" $fichier | awk '{print $NF}'`

        px_ask_yn "Remplacer le numéro : $num par : $numero ?\n" "die"
        shift 2
        echo "exécution du code"
        sudo sed -i -e "s/$num/$numero/g" $fichier
}

function test_appel() {
        fichier=/etc/nagios/objects/commands.cfg
        num=`sudo grep "[0][6][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]$" $fichier | awk '{print $NF}'`
        /usr/lib/nagios/plugins/sip.pl $num
}

case $1 in

        consulter)
                consulter
                ;;
        modifier)
                modifier
                ;;
        appel)
                test_appel
                ;;
        *)
                echo "Utilisation du script"
                echo
                echo "consulter : Affiche le numéro d'astreinte"
                echo
                echo "modifier : Remplace le numéro d'astreinte"
                echo
                echo "appel : Test appel"
                ;;
esac

