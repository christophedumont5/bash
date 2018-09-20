#!/bin/bash

# configuration de l'utilisateur MySQL et de son mot de passe
DB_USER="xxxxxx"
DB_PASS="xxxxxx"
DB_HOST="localhost"

# sous-chemin de destination
OUTDIR=`date +%Y-%m-%d`

# création de l'arborescence
mkdir -p /var/archives/$OUTDIR

# récupération de la liste des bases
DATABASES=`MYSQL_PWD=$DB_PASS mysql -u $DB_USER -e "SHOW DATABASES;" | tr -d "| " | grep -v -e Database -e _schema -e mysql`

# boucle sur les bases pour les dumper
for DB_NAME in $DATABASES; do
    MYSQL_PWD=$DB_PASS mysqldump -u $DB_USER --single-transaction --skip-lock-tables $DB_NAME -h $DB_HOST > /var/archives/$OUTDIR/$DB_NAME.sql
done

# boucle sur les bases pour compresser les fichiers
for DB_NAME in $DATABASES; do
    gzip /var/archives/$OUTDIR/$DB_NAME.sql
done

paroucr arborescence /var/archives
pour chaque $OUTDIR
     fonction cleanup

clean {
for OUTDIR in $OUTDIR; do
    find /var/archives/$OUTDIR -ctime +5 -type f -name "*.gz"
done
}

clean();
