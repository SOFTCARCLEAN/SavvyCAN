## Modification du CMakeLists.txt

Une modification a été apportée au fichier `CMakeLists.txt` pour s'assurer que l'exécutable soit généré dans le dossier `bin/` :

```cmake
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
```

---

# Étape 1 : Compilation du Projet

### 1.1. Nettoyage et Création du Dossier de Build
Avant de compiler, assurez-vous que le dossier de build est propre :

```sh
rm -rf cmake-build-debug
mkdir cmake-build-debug
cd cmake-build-debug
```

### 1.2. Génération des Fichiers de Compilation avec CMake
Dans `cmake-build-debug`, exécutez :

```sh
cmake ..
make -j$(sysctl -n hw.ncpu)
```

Cette commande :
- Supprime tout fichier de build existant.
- Recrée un dossier de build propre.
- Exécute `cmake ..` pour générer les fichiers de compilation.
- Compile le projet en utilisant tous les cœurs CPU disponibles.

### 1.3. Exécution de l'Exécutable
Une fois la compilation terminée, vous pouvez exécuter l'application directement :

```sh
cd bin
```
