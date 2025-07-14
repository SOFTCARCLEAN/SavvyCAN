cmake_minimum_required(VERSION 3.14)
project(SavvyCAN)

set(CMAKE_CXX_STANDARD 17)

# Spécifier le chemin vers Qt5 installé via Homebrew
set(Qt5_DIR "/opt/homebrew/opt/qt@5/lib/cmake/Qt5")

# Trouver Qt5 et ses modules
find_package(Qt5 REQUIRED COMPONENTS Core Gui Widgets SerialPort SerialBus Qml Test PrintSupport)

# Activer l'autogénération pour Qt
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)

# Indiquer où chercher les fichiers .ui
set(CMAKE_AUTOUIC_SEARCH_PATHS ${CMAKE_SOURCE_DIR}/ui)

# Pour la sortie dans bin/
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_AUTOGEN_BUILD_DIR ${CMAKE_BINARY_DIR}/autogen)
set(CMAKE_AUTOUIC_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/autogen/ui)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

# Récupérer tous les fichiers source
file(GLOB_RECURSE PROJECT_SOURCES
        ${CMAKE_SOURCE_DIR}/*.cpp
#        ${CMAKE_SOURCE_DIR}/*.h
        ${CMAKE_SOURCE_DIR}/ui/*.ui
)

# Filtrer pour exclure test ou cmake
foreach(source ${PROJECT_SOURCES})
    string(FIND ${source} "/test/" found_test)
    string(FIND ${source} "CMakeCXXCompilerId.cpp" found_compiler_id)
    if (NOT found_test EQUAL -1 OR NOT found_compiler_id EQUAL -1)
        list(REMOVE_ITEM PROJECT_SOURCES ${source})
    endif()
endforeach()

# Exclure explicitement les anciens moc_*.cpp
foreach(source ${PROJECT_SOURCES})
    string(FIND ${source} "/moc_" found_moc)
    if (NOT found_moc EQUAL -1)
        list(REMOVE_ITEM PROJECT_SOURCES ${source})
    endif()
endforeach()

message(STATUS "Source files: ${PROJECT_SOURCES}")

# Créer l'exécutable
add_executable(SavvyCAN ${PROJECT_SOURCES})

# Inclure pour le moc
file(GLOB_RECURSE QMQTT_HEADERS
        ${CMAKE_SOURCE_DIR}/mqtt/*.h
        ${CMAKE_SOURCE_DIR}/mqtt/*.p.h
)
target_sources(SavvyCAN PRIVATE ${QMQTT_HEADERS})

target_include_directories(SavvyCAN PRIVATE
        ${CMAKE_SOURCE_DIR}
        ${CMAKE_SOURCE_DIR}/dbc
        ${CMAKE_SOURCE_DIR}/connections
        ${CMAKE_SOURCE_DIR}/bus_protocols
        ${CMAKE_SOURCE_DIR}/re
)
# Lier Qt
target_link_libraries(SavvyCAN
        Qt5::Core
        Qt5::Gui
        Qt5::Widgets
        Qt5::SerialPort
        Qt5::SerialBus
        Qt5::Qml
        Qt5::Test
        Qt5::PrintSupport
)