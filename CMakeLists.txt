cmake_minimum_required(VERSION 3.16)

project(Delete VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick Core Qml)
find_package(Qt6 REQUIRED COMPONENTS LinguistTools)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appDelete
    main.cpp initialcheck.cpp initialcheck.h
)
qt_add_translations(appDelete TS_FILES main_hi.ts)

qt_add_qml_module(appDelete
    URI Delete
    VERSION 1.0
    QML_FILES
        Main.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appDelete PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appDelete
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appDelete
    PRIVATE Qt6::Quick Qt6::Core Qt6::Qml
)

include(GNUInstallDirs)
install(TARGETS appDelete
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
