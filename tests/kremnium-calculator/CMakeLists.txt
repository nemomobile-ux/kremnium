if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
    cmake_minimum_required(VERSION 3.16)
    project(kremnium-calculator-example LANGUAGES CXX)

    set(CMAKE_CXX_STANDARD 17)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)

    find_package(Qt6 COMPONENTS Core Gui Qml Quick REQUIRED)
endif()

add_executable(kremnium-calculator
    main.cpp
    Sailfish/Calculator/calculation.cpp
)

target_include_directories(kremnium-calculator PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/Sailfish/Calculator
)

target_compile_definitions(kremnium-calculator PRIVATE
    KREMNIUM_CALC_SOURCE_DIR="${CMAKE_CURRENT_SOURCE_DIR}"
)

target_link_libraries(kremnium-calculator
    Qt6::Core
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
)

install(TARGETS kremnium-calculator RUNTIME
    DESTINATION ${CMAKE_INSTALL_BINDIR})
