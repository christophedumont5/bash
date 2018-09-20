################################################
#!/bin/bash
# christophe dumont
# script sauvegarde base de données glpi
# 20180620
################################################

#définition des variables

User="xxxxxx"
Pass="xxxxxx"
DB="glpidb"
Dump=glpi-gyoni_$(date +%G%m%d).sql
Archive=glpi-gyoni_$(date +%G%m%d).tar.gz
Backupdir="/Sauvegardes"
Errorlog="/var/log/dumps/error.log"
Customlog="/var/log/dumps/dump.log"
Destinataire="######"
Expediteur="######"

#fonction dump+compression

backup() {

        #un peu de ménage
        find $Backupdir -ctime +6 -type f -name "*.gz" -exec rm {} \;

        cd $Backupdir
        mysqldump -u $User -p$Pass $DB > $Dump

        if [ -s $Dump ];
         then
          tar -czvf $Archive $Dump
          if [ -s $Backupdir/$Archive ]
           then
            rm $Backupdir/$Dump
          fi
        fi

        #### à améliorer (récup uniquement champ server, server version, current user, uptime)
        #/usr/bin/mysql -u $User --password=$Pass -e "\s" >> $Customlog

        #bases=`mysql -u $User --password=$Pass -e "show databases;" -B -s`
        #if ($bases exit 0) {
        #echo "Connexion au serveur MariaDB : OK";

        #echo "-------------"
        #for base in $bases
        # do
        #  echo "Nom de la base : $base"
          #echo "nom de la base : $base" >> $Customlog
          #echo "Sauvegarde de la base $base"
          #echo "taille de la base : $";
          #echo "Dump de la base" $DB ": OK ";
        #done
        #echo "-------------"
        #else {
        # echo ("Erreur connexion à la base");
        #}
}

        mail -s "Dump de la base GLPI du serveur srv-glpi-gyoni" -r suprfi@yoni.fr christophe.dumont@yoni.fr < $Customlog

#fonction mail

mail() {
        #bases=`mysql -u $User --password=$Pass -e "show databases;" -B -s | grep glpi`

        #for base in $bases
        # do
        #  echo "Sauvegarde de la base $base : OK" >> $Customlog
        #done

        mail -s "Dump de la base GLPI du serveur srv-glpi-gyoni" -r suprfi@yoni.fr christophe.dumont@yoni.fr < $Customlog
}

#appel des fonctions

backup > $Customlog 2> $Errorlog
#mail

