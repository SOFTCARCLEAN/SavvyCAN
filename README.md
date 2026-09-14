# SavvyCAN
Qt based cross platform canbus tool
(C) 2015-2024 Collin Kidder

A Qt5 based cross platform tool which can be used to load, save, and capture canbus frames.
This tool is designed to help with visualization, reverse engineering, debugging, and
capturing of canbus frames.

Please use the "Discussions" tab here on GitHub to ask questions and interact with the community.

Requires a resolution of at least 1024x768. Fully multi-monitor capable. Works on 4K monitors as well.

You are highly recommended to use the
[CANDue board from EVTV](http://store.evtv.me/proddetail.php?prod=ArduinoDueCANBUS&cat=23).

The CANDue board must be running the GVRET firmware which can also be found
within the collin80 repos.

It is now possible to use any Qt SerialBus driver (socketcan, Vector, PeakCAN, TinyCAN).

It should, however, be noted that use of a capture device is not required to make use
of this program. It can load and save in several formats:

1. BusMaster log file
2. Microchip log file
3. CRTD format (OVMS log file format from Mark Webb-Johnson)
4. GVRET native format
5. Generic CSV file (ID, D0 D1 D2 D3 D4 D5 D6 D7)
6. Vector Trace files
7. IXXAT Minilog files
8. CAN-DO Logs
9. Vehicle Spy log files
10. CANDump / Kayak (Read only)
11. PCAN Viewer (Read Only)
12. Wireshark socketcan PCAP file (Read only)

## Dependencies

Now this code does not depend on anything other than what is in the source tree or available
from the Qt installer.

Uses QCustomPlot available at:

http://www.qcustomplot.com/

However, this source code is integrated into the source for SavvyCAN and one isn't required
to download it separately.

This project requires 5.14.0 or higher because of a dependency on QtSerialBus and other new additions to Qt.

NOTE: As the code in this master branch sits, it does compile with QT6. Support for QT6 is approximately "beta" quality. Most all functions should work, please send issues if found.

It appears that the current binary build for MacOS requires at least MacOS 10.15

## Instructions for compiling:

[Download the newest stable version of Qt directly from qt.io](https://www.qt.io/download/) (You need 5.14.x or newer)

```sh
cd ~

git clone https://github.com/collin80/SavvyCAN.git

cd SavvyCAN

~/Qt/5.14/gcc_64/bin/qmake

make
```

Now run SavvyCAN

```
./SavvyCAN
```

On linux systems you can run `./install.sh` to create a desktop shortcut.

### Compiling in debug mode for additional information

```sh
qmake CONFIG+=debug

make
```

## What to do if your compile failed?

The very first thing to do is try:

```
qmake

make clean

make
```

Did that fix it? Great! If not, ensure that you selected SerialBUS support
when you installed Qt.

### What to do if `qmake` fails with error `Project ERROR: Unknown module(s) in QT: qml serialbus help` on Ubuntu? :

`sudo apt install libqt5serialbus5-dev libqt5serialport5-dev qtdeclarative5-dev qttools5-dev`

### Used Items Requiring Attribution

nodes by Adrien Coquet from the Noun Project

message by Vectorstall from the Noun Project

signal by shashank singh from the Noun Project

signal by juli from the Noun Project

signal by yudi from the Noun Project

Death by Adrien Coquet from the Noun Project

# Compilation et Exécution de SavvyCAN sur macOS (Apple Silicon)

Ce guide explique comment compiler et exécuter l'application SavvyCAN sur macOS avec une architecture Apple Silicon (M1/M2).

## Pré-requis

Assurez-vous d'avoir installé les outils suivants :

- Xcode (depuis l'App Store)
- Homebrew (https://brew.sh/)

## Installation des dépendances

1. Installez CMake :

    ```bash
    brew install cmake
    ```

2. Installez Qt5 via Homebrew :

    ```bash
    brew install qt@5
    ```

Qt5 est installé dans `/opt/homebrew/opt/qt@5`. Étant donné que Qt5 est keg-only, il est nécessaire d'ajouter les chemins à votre environnement.

Ajoutez ces lignes à votre fichier `~/.zshrc` :

    ```bash
    export PATH="/opt/homebrew/opt/qt@5/bin:$PATH"
    export LDFLAGS="-L/opt/homebrew/opt/qt@5/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/qt@5/include"
    ```

Rechargez la configuration de votre shell :

    ```bash
    source ~/.zshrc
    ```

## Compilation

1. Dans le répertoire du projet SavvyCAN, exécutez :

    ```bash
    /opt/homebrew/opt/qt@5/bin/qmake CONFIG+=sdk_no_version_check
    ```

Cela permet d'ignorer l'avertissement sur la version du SDK macOS.

2. Compilez le projet :

    ```bash
    make
    ```

Si tout se passe bien, cela créera un bundle d'application `SavvyCAN.app`.


## Compilation alternative avec CMake

Si vous préférez utiliser CMake plutôt que qmake, utilisez les commandes suivantes :

   ```bash
      rm -rf cmake-build-debug
      mkdir cmake-build-debug
      cd cmake-build-debug
      cmake ..
      make
      cd ../
      bin/SavvyCAN
   ```

Cela générera le binaire dans le dossier `cmake-build-debug`.

## Génération des fichiers de compilation :
  ```bash
     cmake ..
     make -j$(sysctl -n hw.ncpu)
  ```


## Exécution

1. Pour lancer l'application :

    ```bash
   cd ../
   open SavvyCAN.app
    ```

2. Ou pour exécuter le binaire directement :

    ```bash 
    bin/SavvyCAN 

    ```

# SavvyCAN - Build & Run

## 📦 Build rapide

Tout est configuré pour que les fichiers générés (build system, moc, uic, binaires) aillent dans le dossier `build/` pour garder un projet propre.

### 🔧 Compilation & exécution

   ```bash
      ./scripts/rebuild.sh
   ```

### Activer le script
   ```bash
      chmod +x scripts/rebuild.sh
   ```


## Résolution des erreurs fréquentes

### 1. zsh: no such file or directory: ./SavvyCAN
Cela signifie que l'exécutable est contenu dans le bundle d'application. Utilisez la commande suivante :
    ```bash
    ./SavvyCAN.app/Contents/MacOS/SavvyCAN
    ```

### 2. `Qt has only been tested with version X of the platform SDK, you're using Y.`
Ajoutez `CONFIG+=sdk_no_version_check` lors de l'appel à `qmake` :

    ```bash
    /opt/homebrew/opt/qt@5/bin/qmake CONFIG+=sdk_no_version_check
    ```

Cela permettra de contourner l'avertissement lié à la version du SDK macOS.

### 3. `Undefined symbols for architecture arm64` lors de l'utilisation de Qt6
SavvyCAN est conçu pour Qt5. Assurez-vous d'utiliser `qt@5` comme décrit ci-dessus.

## Vérification de la version de Qt utilisée

    ```bash
    qmake --version
    ```

Vous devez voir une sortie indiquant quelque chose comme :

    ```
    QMake version 3.1
    Using Qt version 5.15.16 in /opt/homebrew/Cellar/qt@5/5.15.16/lib
    ```

Cela confirme que vous utilisez bien la version Qt5 installée via Homebrew.


# Utilisation des fichiers .fsd dans SavvyCAN

SavvyCAN permet de charger des fichiers `.fsd` (Frame Send Data) afin d’envoyer automatiquement des trames CAN définies.

Chaque ligne d’un fichier `.fsd` correspond à une trame et est composée des éléments suivants :
```
F#<Bus>#<ID>#<NomMessage>#<Len>#<Ext>#<Rem>#<Data...> #<Trigger>#<Modifications>#
```

---

### 📂 Différence entre l’ancien et le nouveau modèle `.fsd`

SavvyCAN a deux manières d’interpréter et stocker les trames dans les fichiers `.fsd` :

#### 🔹 Ancien modèle (brut)
```
F#0#0x0CFF01BF#8#T#F#0x00 0x22 0x8A 0x00 0xFF 0x00 0x00 0x00 #200ms#neutral#
```
- Le champ **NomMessage** est vide → la 3e position après l’ID est directement utilisée pour la longueur (`8`).
- L’utilisateur doit se fier uniquement à l’ID et aux données pour comprendre la signification de la trame.
- Le champ **Modifications** contient souvent un mot-clé générique (`neutral`).

#### 🔹 Nouveau modèle (customisé)
```
F#0#0x0CFF01BF#test##T#F#0x00 0x22 0x8C 0x00 0xFF 0x00 0x00 0x00 #100MS#test du custom#
```
- Le champ **NomMessage** est rempli (`test`) → permet d’identifier directement la fonction de la trame dans l’interface.
- Le champ **Len** est vide (`##`) car SavvyCAN calcule automatiquement la longueur.
- Le contenu des **données** peut être modifié (exemple : `0x8A → 0x8C`).
- La fréquence d’envoi (**Trigger**) est paramétrée avec une valeur plus flexible (`200ms → 100MS`).
- Le champ **Modifications** est libre et sert désormais à documenter la trame (`test du custom`).

---

👉 **En résumé** :
- **Ancien modèle** = minimaliste, basé uniquement sur ID, longueur et données.
- **Nouveau modèle** = enrichi, avec un champ `NomMessage` pour l’identification, un `Trigger` flexible et un champ `Modifications` documenté.  

# 📝 Notes locales perso (setup Mac)

Section perso pour se souvenir de ce qu'il faut sur la machine pour faire tourner ce projet, notamment après un "clean" du Mac.

## Ce dont ce projet a besoin

- **Xcode Command Line Tools** (compilateur `clang`) — vérifier avec `xcode-select -p`
- **Homebrew** — https://brew.sh/ — vérifier avec `brew --version`
- **CMake** — vérifier avec `cmake --version`
- **Qt 5** (via `brew install qt@5`, formule *keg-only*) — vérifier avec `/opt/homebrew/opt/qt@5/bin/qmake --version`
  - Modules Qt utilisés par le projet : `Core Gui Widgets SerialPort SerialBus Qml Test PrintSupport Network OpenGL Help`
  - ⚠️ `qt@5` est marquée *deprecated* par Homebrew (dépréciation prévue mi-2027) mais fonctionne toujours.
- Le `PATH` doit inclure `/opt/homebrew/opt/qt@5/bin` (ligne à avoir dans `~/.zshrc`) :
  ```bash
  export PATH="/opt/homebrew/opt/qt@5/bin:$PATH"
  ```

### Vérif rapide de l'état de la machine (aucune installation, juste des checks)

```bash
xcode-select -p
brew --version
cmake --version
/opt/homebrew/opt/qt@5/bin/qmake --version
```

Si une de ces commandes échoue, c'est ce qui a été perdu lors du clean et qu'il faut réinstaller :

```bash
xcode-select --install          # si Xcode CLT manquant
brew install cmake              # si cmake manquant
brew install qt@5               # si Qt5 manquant
```

*(Ne pas lancer ces commandes sans vérifier d'abord — elles ne sont notées ici qu'à titre de mémo.)*

## Comment lancer le projet

### Option A — binaire déjà compilé (le plus rapide si `bin/SavvyCAN` existe déjà)

```bash
bin/SavvyCAN
```

### Option B — via le script de rebuild (CMake, recommandé)

```bash
./scripts/rebuild.sh
```

Ce script nettoie `cmake-build-debug/`, relance `cmake` + `make`, puis lance directement `bin/SavvyCAN`.

### Option C — CMake à la main

```bash
rm -rf cmake-build-debug
mkdir cmake-build-debug
cd cmake-build-debug
cmake ..
make -j$(sysctl -n hw.ncpu)
cd ..
bin/SavvyCAN
```

### Option D — qmake (produit un bundle `SavvyCAN.app`)

```bash
/opt/homebrew/opt/qt@5/bin/qmake CONFIG+=sdk_no_version_check
make
open SavvyCAN.app
# ou directement :
./SavvyCAN.app/Contents/MacOS/SavvyCAN
```

## Repères importants

- `CMakeLists.txt` pointe en dur vers `Qt5_DIR=/opt/homebrew/opt/qt@5/lib/cmake/Qt5` — si Homebrew change ce chemin un jour, c'est ici qu'il faut corriger.
- Les dossiers `cmake-build-debug/`, `cmake-build-release/`, `bin/`, `.idea/`, `help/CMakeFiles/`, `help/CMakeCache.txt` sont des artefacts de build générés localement (non versionnés) — pas besoin de s'en inquiéter s'ils apparaissent dans `git status`.
