if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
    cmake_minimum_required(VERSION 3.16)
    project(kremnium-clock-example LANGUAGES CXX)

    set(CMAKE_CXX_STANDARD 17)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)

    find_package(Qt6 COMPONENTS Core Gui Qml Quick REQUIRED)
endif()

add_executable(kremnium-clock
    main.cpp
)

target_compile_definitions(kremnium-clock PRIVATE
    KREMNIUM_CLOCK_SOURCE_DIR="${CMAKE_CURRENT_SOURCE_DIR}"
)

target_link_libraries(kremnium-clock
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
)

install(TARGETS kremnium-clock RUNTIME
    DESTINATION ${CMAKE_INSTALL_BINDIR})
