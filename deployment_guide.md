# SavvyCAN – deployment_guide.md

1. **Modification du `CMakeLists.txt`**  
   - Ajout de la ligne :
     ```cmake
     set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
     ```
     pour générer l'exécutable dans `bin/`.

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
   - Exécuter :
     ```sh
     windeployqt --verbose=2 bin/SavvyCAN.exe
     ```
   - ⚠️ **Ne pas utiliser `--release`**, sinon certaines dépendances Qt ne seront pas copiées.

4. **Correction des erreurs liées aux DLLs Qt**  
   - Si `windeployqt` ne trouve pas certains fichiers, s'assurer que le chemin des plugins Qt est bien défini :
     ```sh
     set QT_PLUGIN_PATH=D:\Qt\5.15.2\mingw81_64\plugins
     ```

5. **Vérification et inclusion des fichiers nécessaires**  
   - Vérifier que les dossiers suivants sont bien présents dans `bin/` :
     - `bearer`
     - `canbus`
     - `iconengines`
     - `imageformats`
     - `platforms`
     - `printsupport`
     - `styles`
     - `translations`
   - Ajouter les fichiers dans `setup.iss` pour qu'ils soient inclus dans l'installateur.

6. **Création de l'installateur avec Inno Setup**  
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
     pour générer `SavvyCAN_Setup.exe`.

7. **Correction des erreurs de compilation Inno Setup**  
   - Si `LICENSE.txt` est introuvable, commenter la ligne correspondante dans `setup.iss`.
   - Vérifier que tous les fichiers listés dans `[Files]` existent bien dans `bin/`.

8. **Automatisation avec GitHub Actions**  
   - Extraction automatique de la version depuis le tag :
     ```yaml
     - name: Extract version from tag
       run: echo "VERSION=${{ github.ref_name }}" >> $GITHUB_ENV
     ```
   - Compilation et création de l'installateur dans GitHub Actions.
   - Correction du chemin des fichiers dans Inno Setup pour éviter les erreurs `No files found matching`.

9. **Publication de la Release sur GitHub**  
   - Vérifier que `SavvyCAN_Setup.exe` est bien dans `Output/` avant l'upload.
   - Ajout de l'upload dans GitHub Actions :
     ```yaml
     - name: Upload Setup
       uses: actions/upload-artifact@v2
       with:
         name: SavvyCAN_Setup
         path: Output/SavvyCAN_Setup.exe
     ```
   - Vérifier les permissions GitHub pour l'upload de release (`contents: write`).

10. **Validation du déploiement**  
    - Exécuter `bin/SavvyCAN.exe` après déploiement.
    - Vérifier que tous les fichiers nécessaires (DLLs, plugins) sont bien présents.
    - Tester l'installation à partir de `SavvyCAN_Setup.exe`.