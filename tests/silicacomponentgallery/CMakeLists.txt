if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
    cmake_minimum_required(VERSION 3.16)
    project(kremnium-silicacomponentgallery-example LANGUAGES CXX)

    set(CMAKE_CXX_STANDARD 17)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)

    find_package(Qt6 COMPONENTS Core Gui Qml Quick REQUIRED)
endif()

add_executable(kremnium-silicacomponentgallery
    main.cpp
)

target_compile_definitions(kremnium-silicacomponentgallery PRIVATE
    KREMNIUM_GALLERY_SOURCE_DIR="${CMAKE_CURRENT_SOURCE_DIR}"
)

target_link_libraries(kremnium-silicacomponentgallery
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
)

install(TARGETS kremnium-silicacomponentgallery RUNTIME
    DESTINATION ${CMAKE_INSTALL_BINDIR})
