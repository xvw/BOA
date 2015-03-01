# BOA : Basic Ocsigen Application
> BOA est un sous-ensemble de [Ocsigen](http://ocsigen.org) pour construire facilement des applications web et mobile. Son objectif principal est d'être plus facile à utiliser que l'ensemble d'Ocsigen (un peu comme [Sinatra](http://http://www.sinatrarb.com/) pour [Ruby On Rails](http://rubyonrails.org/)).

Ce document n'évoque pas les concepts fondamentaux de Ocsigen, comme par exemple, le HTML statiquement typé ou autre. Il faut donc, pour une bonne compréhension, avoir déjà éffleuré la conception d'applications web avec Ocsigen.

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

## Première application: un Hello World
En général, on dédie un module spécialisé à un service. Par exemple, dans notre cas, on décrira la **vue** (soit la page HTML renvoyée) à un fichier `app/hello.eliom`. On ouvre le module `Boa_core` pour bénéficier de fonctions simple et on peut écrire une variable qui décrit la vue de l'application. Par exemple :

```ocaml
open Boa_core
       
(* Vue de l'application *)
let view () =
  let open View in 
  Boa_skeleton.return
    "Hello World !"
    [
      h1 [pcdata "Hello le monde!"];
    ]

```

On ouvre le module `View`(situé dans le module `Boa_core` qui importe le module `Html.D` (se réferrer à **TyXML** pour plus d'informations). La fonction `Boa_skeleton.raw title content` renvoi une page avec un titre et un contenu mis dans un contexte **Lwt**.

Une fois que la vue est écrite, on peut se rendre dans le fichier `app/boa_services.eliom` pour enregistrer le service.

> Il est nécéssaire de se rendre dans `boa_services` pour garantir que le fichier `hello.eliom` soit compilé.

Pour enregistrer un service, il suffit de faire ceci dans `app/boa_services.eliom` :

```ocaml
open Eliom_content
open Eliom_parameter
open Boa_core

(* Custom services registration *)
let hello =
  Register.page
    ~path:["hello"]
    Hello.view
```
Les ouvertures sont présentes pour plus de confort. Une "page" est un service qui ne prend pas de paramètres **GET** ou **POST**. On peut maintenant tester l'application au moyen de `make run` et en se rendant à `http://localhost:8000`.

## Avec des paramètres GET
**Code de `hello.eliom`**
```ocaml
open Boa_core
       
(* Vue de l'application *)
let general_view name =
  let open View in 
  Boa_skeleton.return
    "Hello !"
    [
      h1 [pcdata ("Hello " ^ name ^" !")];
    ]

let view () = general_view "le monde"
let specific_view name _ = general_view name
```

Cette fois ci, la fonction `specific_view` prend deux arguments. Le premier est le paramètre **GET**, les second est ignoré.

**Code de `boa_services.eliom`**
```ocaml
open Eliom_content
open Eliom_parameter
open Boa_core

(* Custom services registration *)
let hello =
  Register.page
    ~path:["hello"]
    Hello.view

let specific_hello =
  Register.get
    ~params:(suffix (string "name"))
    ~path:["specific_hello"]
    Hello.specific_view
```

Cette fois, il est possible de spécifier un nom à saluer. Par exemple : `http://localhost:8000/specific_hello/Nuki`.
