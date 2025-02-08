SET(SOURCES
    plugin.cpp)

SET(HEADERS
    plugin.h)

set(QML
    qml/ApplicationWindow.qml
    kremnium.json)

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
        QML_FILES qml/ContextMenu.qml
        QML_FILES qml/PullDownMenu.qml
        QML_FILES qml/RemorsePopup.qml
        QML_FILES qml/Page.qml
        QML_FILES qml/MenuItem.qml
        QML_FILES qml/ViewPlaceholder.qml
        QML_FILES qml/Label.qml
        QML_FILES qml/VerticalScrollDecorator.qml
        QML_FILES qml/PageHeader.qml
        QML_FILES qml/RemorseItem.qml
        QML_FILES qml/SilicaListView.qml
        QML_FILES qml/IconButton.qml
        QML_FILES qml/DockedPanel.qml
        QML_FILES qml/BusyIndicator.qml
        QML_FILES qml/SilicaFlickable.qml
        QML_FILES qml/SectionHeader.qml
)

target_link_libraries(kremniumplugin PUBLIC
    Qt6::Core
    Qt6::Qml
    Qt6::Quick)

install(TARGETS kremniumplugin
    RUNTIME DESTINATION "${QT_INSTALL_QML}/Sailfish/Silica"
    BUNDLE DESTINATION "${QT_INSTALL_QML}/Sailfish/Silica"
    LIBRARY DESTINATION "${QT_INSTALL_QML}/Sailfish/Silica"
)

install(DIRECTORY qml/
    DESTINATION ${QT_INSTALL_QML}/Sailfish/Silica)
