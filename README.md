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

# Compilation et Exécution de SavvyCAN sur macOS (Apple Silicon - M1/M2)

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

## Exécution

1. Pour lancer l'application :

    ```bash
    open SavvyCAN.app
    ```

2. Ou pour exécuter le binaire directement :

    ```bash
    ./SavvyCAN.app/Contents/MacOS/SavvyCAN
    ```

## Résolution des erreurs fréquentes

### 1. `zsh: no such file or directory: ./SavvyCAN`
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




