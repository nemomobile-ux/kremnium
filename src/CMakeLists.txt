SET(SOURCES
    plugin.cpp
    kremniumtheme.cpp
    declarativepagestatus.cpp
    declarativetruncationmode.cpp)

SET(HEADERS
    plugin.h
    kremniumtheme.h
    declarativepagestatus.h
    declarativetruncationmode.h )

set(QML
    qml/ApplicationWindow.qml
    qml/ContextMenu.qml
    qml/PullDownMenu.qml
    qml/RemorsePopup.qml
    qml/Page.qml
    qml/MenuItem.qml
    qml/ViewPlaceholder.qml
    qml/Label.qml
    qml/VerticalScrollDecorator.qml
    qml/PageHeader.qml
    qml/RemorseItem.qml
    qml/SilicaListView.qml
    qml/IconButton.qml
    qml/DockedPanel.qml
    qml/BusyIndicator.qml
    qml/SilicaFlickable.qml
    qml/SectionHeader.qml
    qml/CoverPage.qml
    qml/CoverAction.qml
    qml/CoverBackground.qml
    qml/CoverActionList.qml)

qt6_add_qml_module(kremniumplugin
    URI Sailfish.Silica
    VERSION 1.0
    PLUGIN_TARGET kremniumplugin
    NO_GENERATE_PLUGIN_SOURCE
    SOURCES
        ${SOURCES}
        ${HEADERS}
    QML_FILES
        ${QML}
    OUTPUT_DIRECTORY
        ${CMAKE_BINARY_DIR}/Sailfish/Silica
        SOURCES declarativewindow.h declarativewindow.cpp
)

target_link_libraries(kremniumplugin PUBLIC
    Qt6::Core
    Qt6::Qml
    Qt6::Quick
    PkgConfig::MLITE
    PkgConfig::NEMOCORE)

install(TARGETS kremniumplugin
    RUNTIME DESTINATION "${QT_INSTALL_QML}/Sailfish/Silica"
    BUNDLE DESTINATION "${QT_INSTALL_QML}/Sailfish/Silica"
    LIBRARY DESTINATION "${QT_INSTALL_QML}/Sailfish/Silica"
)

install(DIRECTORY qml/
    DESTINATION ${QT_INSTALL_QML}/Sailfish/Silica)
