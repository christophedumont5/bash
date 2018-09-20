#!/bin/bash

wwwdirs=(/var/www/html/)
date=`date +%Y-%m-%d`
Errorlog="/var/log/back_www_error.log"
Customlog="/var/log/back_www.log"
Destinataire="support.rfi@yoni.fr"
Expediteur="backup_www@glpi.groupeyoni.fr"

backup() {

find /home/sauvegardes/www/ -ctime +6 -type f -name "*.tar.gz" -exec rm {} \;

for dir in `ls -1 $wwwdirs`
do
    tar czvf /home/sauvegardes/www/$dir.$date.tar.gz $wwwdirs$dir
done

mail -s "Backup des sites du serveur srv-web-02" -r suprfi@yoni.fr christophe.dumont@yoni.fr < $Customlog
}

backup > $Customlog 2> $Errorlog
