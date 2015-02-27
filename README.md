# BOA : Basic Ocsigen Application
> BOA est un sous-ensemble de [Ocsigen](http://ocsigen.org) pour construire facilement des applications web et mobile. Son objectif principal est d'être plus facile à utiliser que l'ensemble d'Ocsigen (un peu comme [Sinatra](http://http://www.sinatrarb.com/) pour [Ruby On Rails](http://rubyonrails.org/)). Sauf que tout Ocsigen est utilisable dans une application BOA.

## Installation et lancement
Téléchargement de la dernière version de BOA via : `git clone https://github.com/Phutur/BOA <your-project-name>`.
Lancement du serveur : `make run`.

## Anatomie d'une application BOA

*   `app/` : Fichiers sources (eliom et OCaml)
*   `config/` :  Configuration du serveur
*   `data/` : Données persistantes
*   `log/` : Journaux du serveur
*   `public/` : Assets complémentaires (CSS, Javascript)
*   `tmp` : Données temporaires

La compilation entraine la génération d'un répertoire `_build`.

### Morphologie du code source
