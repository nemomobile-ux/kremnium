SET(SOURCES
    plugin.cpp
    kremniumtheme.cpp
    declarativepagestatus.cpp
    declarativewindow.cpp
    declarativetruncationmode.cpp
    declarativebuttonlayout.cpp
    declarativeregexpvalidator.cpp
    silicascreen.cpp)

SET(HEADERS
    plugin.h
    kremniumtheme.h
    declarativepagestatus.h
    declarativetruncationmode.h
    declarativepagestackaction.h
    declarativedock.h
    declarativetouchinteraction.h
    declarativewindow.h
    silicascreen.h
    silicaorientation.h
    silicacover.h
    silicaformat.h
    silicabusyindicatorsize.h
    buttonlayoutattached.h
    enterkeyattached.h
    declarativebuttonlayout.h
    declarativeregexpvalidator.h)

set(QML
    qml/AddAnimation.qml
    qml/ApplicationWindow.qml
    qml/BackgroundItem.qml
    qml/BusyIndicator.qml
    qml/BusyLabel.qml
    qml/Button.qml
    qml/Clipboard.qml
    qml/ComboBox.qml
    qml/ContextMenu.qml
    qml/CoverAction.qml
    qml/CoverActionList.qml
    qml/CoverBackground.qml
    qml/CoverPage.qml
    qml/CoverPlaceholder.qml
    qml/Dialog.qml
    qml/DialogHeader.qml
    qml/ColorPickerPage.qml
    qml/DockedPanel.qml
    qml/Drawer.qml
    qml/ExpandingSection.qml
    qml/ExpandingSectionGroup.qml
    qml/FadeAnimation.qml
    qml/FadeAnimator.qml
    qml/FirstTimeUseCounter.qml
    qml/Formatter.qml
    qml/FullscreenContentPage.qml
    qml/GlassItem.qml
    qml/GridItem.qml
    qml/HapticsEffect.qml
    qml/Icon.qml
    qml/IconButton.qml
    qml/IconComboBox.qml
    qml/IconMenuItem.qml
    qml/IconTextSwitch.qml
    qml/InfoLabel.qml
    qml/InteractionHintLabel.qml
    qml/Label.qml
    qml/LinkedLabel.qml
    qml/ListItem.qml
    qml/MenuItem.qml
    qml/MenuLabel.qml
    qml/MiniComboBox.qml
    qml/Notice.qml
    qml/OpacityRampEffect.qml
    qml/OpacityRampEffectBase.qml
    qml/Page.qml
    qml/PagedView.qml
    qml/PageHeader.qml
    qml/PanelBackground.qml
    qml/PasswordField.qml
    qml/ProgressBar.qml
    qml/ProgressCircle.qml
    qml/PullDownMenu.qml
    qml/RemorseItem.qml
    qml/RemorsePopup.qml
    qml/RemoveAnimation.qml
    qml/SearchField.qml
    qml/SecondaryButton.qml
    qml/SectionDivider.qml
    qml/SectionHeader.qml
    qml/KremniumFlickable.qml
    qml/SilicaGridView.qml
    qml/SilicaListView.qml
    qml/Slider.qml
    qml/Switch.qml
    qml/TapInteractionHint.qml
    qml/TextArea.qml
    qml/TextEditorLabel.qml
    qml/TextField.qml
    qml/TextSwitch.qml
    qml/TouchInteractionHint.qml
    qml/ValueButton.qml
    qml/VerticalScrollDecorator.qml
    qml/ViewPlaceholder.qml)

set_source_files_properties(qml/Clipboard.qml PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)
set_source_files_properties(qml/Formatter.qml PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)
set_source_files_properties(qml/KremniumFlickable.qml PROPERTIES
    QT_QML_SOURCE_TYPENAME "SilicaFlickable"
)

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
)

target_link_libraries(kremniumplugin PUBLIC
    Qt6::Core
    Qt6::Qml
    Qt6::Quick
    PkgConfig::MLITE
    PkgConfig::NEMOCORE)
if(TARGET Qt6::Multimedia)
    target_link_libraries(kremniumplugin PUBLIC Qt6::Multimedia)
endif()

qt6_add_qml_module(silicaprivateplugin
    URI Sailfish.Silica.private
    VERSION 1.0
    PLUGIN_TARGET silicaprivateplugin
    NO_GENERATE_PLUGIN_SOURCE
    SOURCES
        private/plugin.cpp
        private/plugin.h
        private/TabViewAction.h
    QML_FILES
        qml/private/TabItem.qml
        qml/private/TabBar.qml
        qml/private/TabView.qml
    OUTPUT_DIRECTORY
        ${CMAKE_BINARY_DIR}/Sailfish/Silica/private
)

target_link_libraries(silicaprivateplugin PUBLIC
    Qt6::Core
    Qt6::Qml
    Qt6::Quick
)

install(TARGETS kremniumplugin silicaprivateplugin
    RUNTIME DESTINATION "${QT_INSTALL_QML}/Sailfish/Silica"
    BUNDLE DESTINATION "${QT_INSTALL_QML}/Sailfish/Silica"
    LIBRARY DESTINATION "${QT_INSTALL_QML}/Sailfish/Silica"
)

install(DIRECTORY qml/
    DESTINATION ${QT_INSTALL_QML}/Sailfish/Silica)
