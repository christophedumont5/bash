# Scripts Bash

Des scripts bash pour utilisations diverses et variées 

## Pré-requis 

Il faut installer la librairie bc sur la machine à monitorer, ainsi que le plugin nrpe 

sudo yum install bc
sudo yum install nrpe nagios-plugins-users nagios-plugins-load nagios-plugins-swap nagios-plugins-disk nagios-plugins-procs

sudo apt-get install bc
sudo apt-get install nrpe nagios-plugins-users nagios-plugins-load nagios-plugins-swap nagios-plugins-disk nagios-plugins-procs

## Installation

Côté serveur, créer un service comme suit : 

define service {
        host_name                               machine à monitorer
        service_description                     memoire
        check_command                           check_nrpe!check_mem
        use                                     linux-generic-service
        check_interval                          5
        max_check_attempts                      3
        notification_options                    c,r
        contact_groups                          mailpx
        notification_period                     exclusion_nuit
        }

Côté client, 

Copier le fichier mem.sh sous /usr/lib64/nagios/plugins
Fixer les droits à 755 et le propritéaire root:root

Créer la commande check_mem en éditant le fichier /etc/nagios/nrpe

command[check_mem]=/usr/lib64/nagios/plugins/mem.sh

## Auteur

* **Christophe Dumont** 
