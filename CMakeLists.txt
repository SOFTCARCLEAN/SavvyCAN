cmake_minimum_required(VERSION 3.14)
project(SavvyCAN)

set(CMAKE_CXX_STANDARD 17)

# Spécifier le chemin vers Qt5 installé via Homebrew
set(Qt5_DIR "/opt/homebrew/opt/qt@5/lib/cmake/Qt5")

# Trouver Qt5 et ses modules
find_package(Qt5 REQUIRED COMPONENTS Core Gui Widgets SerialPort SerialBus Qml Test PrintSupport)
#set(CMAKE_AUTOUIC_SEARCH_PATHS ${CMAKE_SOURCE_DIR}/ui)  # Indique où chercher les fichiers .ui

# Force AUTOMOC et AUTOUIC à être actifs
#set(CMAKE_AUTOMOC ON)
#set(CMAKE_AUTOUIC ON)
#set(CMAKE_AUTORCC ON)

# Placer les fichiers générés par moc/uic/rcc dans le dossier source (comme le ferait qmake)
#set(CMAKE_AUTOGEN_OUTPUT_DIR ${CMAKE_SOURCE_DIR})

# Ajoute le dossier source à l'include path pour trouver les ui_*.h générés
#include_directories(${CMAKE_SOURCE_DIR})
# Récupérer tous les fichiers .cpp
file(GLOB_RECURSE PROJECT_SOURCES ${CMAKE_SOURCE_DIR}/*.cpp)

# Exclure les fichiers dans "test/"
foreach(source ${PROJECT_SOURCES})
    string(FIND ${source} "/test/" found_test)
    if (NOT found_test EQUAL -1)
        list(REMOVE_ITEM PROJECT_SOURCES ${source})
    endif()
endforeach()

# Exclure les fichiers CMakeCXXCompilerId
foreach(source ${PROJECT_SOURCES})
    string(FIND ${source} "CMakeCXXCompilerId.cpp" found_compiler_id)
    if (NOT found_compiler_id EQUAL -1)
        list(REMOVE_ITEM PROJECT_SOURCES ${source})
    endif()
endforeach()

message(STATUS "Final source files: ${PROJECT_SOURCES}")

# Ajouter les dossiers contenant les headers
include_directories(
        ${CMAKE_SOURCE_DIR}  # Racine du projet
        ${CMAKE_SOURCE_DIR}/dbc  # Ajouter d'autres si besoin
)

qt5_wrap_ui(UI_HEADERS ui/mainwindow.ui)

# Définir le dossier de sortie pour l'exécutable
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)

# Ajouter l'exécutable
add_executable(SavvyCAN ${PROJECT_SOURCES} ${UI_HEADERS})

# Lier Qt5 aux bibliothèques
target_link_libraries(SavvyCAN Qt5::Core Qt5::Gui Qt5::Widgets Qt5::SerialPort Qt5::SerialBus Qt5::Qml Qt5::Test Qt5::PrintSupport)