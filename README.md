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
Le code d'une application est placé dans le répertoire `app/`. Il est évidemment conseillé d'ajouter ses propres fichiers plutôt que de modifier les fichiers existants, sauf dans le cas des définitions de services. Le module `Boa_services` exposant les modules adéquats.

*   `boa.eliom` : Point d'entrée de l'application.
*   `boa_config.eliom` : Module de configuration (nom de l'application, identifiants SQL)
*   `boa_core.eliom` : Ensemble de *Helpers* à la définition de services
*   `boa_db.ml` : Pool de connexion concurrent à **Postgres** et interface de requêtage SQL (utilisant Macaque)
*   `boa_errors.eliom` : Ensemble d'erreur pré-enregistrées (404, paramètres)
*   `boa_gui.eliom` : Un framework front-end pour construire des GUI's
*   `boa_sample.eliom` : Des snippets de services servant d'example à BOA
*   `boa_services.eliom` : Définition des services de l'application
*   `boa_skeleton.eliom` : Fonctions de génération de page Html5 (valides!)
*   `boa_ui.eliom` : *Helpers* pour les interactions clients-serveur.
