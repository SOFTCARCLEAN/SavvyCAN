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

# SavvyCAN – deployment_guide.md

1. **Modification du `CMakeLists.txt`**  
   Ajout de la ligne :
   ```cmake
   set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
   ```
   pour que l'exécutable soit généré dans `bin/`.

2. **Compilation du Projet**
    - Nettoyage et création du dossier de build :
      ```sh
      rm -rf cmake-build-debug
      mkdir cmake-build-debug
      cd cmake-build-debug
      ```
    - Génération des fichiers de compilation :
      ```sh
      cmake ..
      make -j$(sysctl -n hw.ncpu)
      ```
    - Exécution de l'exécutable :
      ```sh
      cd bin
      ./SavvyCAN
      ```

3. **Déploiement avec `windeployqt`**  
   Pour Windows, exécutez :
   ```sh
   windeployqt --verbose=2 bin/SavvyCAN.exe
   ```
   ⚠️ **Ne pas utiliser `--release`**, sinon certaines dépendances Qt ne seront pas copiées.

4. **Correction des erreurs liées aux DLLs Qt**  
   Si `windeployqt` ne trouve pas certains fichiers, s'assurer que le chemin des plugins Qt est bien défini :
   ```sh
   set QT_PLUGIN_PATH=D:\Qt\5.15.2\mingw81_64\plugins
   ```

5. **Création de l'installateur avec Inno Setup**
    - Vérifier que l'exécutable et les DLLs sont bien dans `bin/`
    - Modifier `setup.iss` pour inclure :
      ```ini
      [Setup]
      SourcePath=bin
      ```
    - Exécuter :
      ```sh
      "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" setup.iss
      ```
   pour générer `mysetup.exe`.

6. **Correction des erreurs de compilation Inno Setup**
    - Si `LICENSE.txt` est introuvable, commenter la ligne correspondante dans `setup.iss`.
    - Vérifier que tous les fichiers listés dans `[Files]` existent bien dans `bin/`.

7. **Automatisation avec GitHub Actions**
    - Extraction automatique de la version depuis le tag :
      ```yaml
      - name: Extract version from tag
        run: echo "VERSION=${{ github.ref_name }}" >> $GITHUB_ENV
      ```
    - Compilation et création de l'installateur dans GitHub Actions.

8. **Correction du chemin des fichiers dans Inno Setup**  
   Pour éviter les erreurs `No files found matching "D:\a\SavvyCAN\SavvyCAN\..\bin\SavvyCAN.exe"`, s'assurer que `SourcePath` est correctement défini.

9. **Validation du déploiement**
    - Exécuter `bin/SavvyCAN.exe` après déploiement.
    - Vérifier que tous les fichiers nécessaires (DLLs, plugins) sont bien présents.
    - Tester l'installation à partir de `mysetup.exe`.