SET(SOURCES
    plugin.cpp)

SET(HEADERS
    plugin.h)

set(QML
    qml/WebViewPage.qml)

qt6_add_qml_module(kremniumwebplugin
    URI Sailfish.WebView
    VERSION 1.0
    PLUGIN_TARGET kremniumwebplugin
    NO_GENERATE_PLUGIN_SOURCE
    SOURCES
        ${SOURCES}
        ${HEADERS}
    QML_FILES
        ${QML}
    OUTPUT_DIRECTORY
        ${CMAKE_BINARY_DIR}/Sailfish/WebView
)

target_link_libraries(kremniumwebplugin PUBLIC
    Qt6::Core
    Qt6::Qml
    Qt6::Quick
    Qt6::WebEngineQuick)

install(TARGETS kremniumwebplugin
    RUNTIME DESTINATION "${QT_INSTALL_QML}/Sailfish/WebView"
    BUNDLE DESTINATION "${QT_INSTALL_QML}/Sailfish/WebView"
    LIBRARY DESTINATION "${QT_INSTALL_QML}/Sailfish/WebView"
)

install(DIRECTORY qml/
    DESTINATION ${QT_INSTALL_QML}/Sailfish/WebView)
