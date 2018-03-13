cmake_minimum_required(VERSION 3.9)

project(GeoFeatures LANGUAGES NONE)

message(STATUS "Configuring GeoFeatures for ${CMAKE_SYSTEM_NAME} ${CMAKE_SYSTEM_PROCESSOR}")
message(STATUS "  Build type: ${CMAKE_BUILD_TYPE}")
message(STATUS "")

# Git tag hash == 1.0.0
set(BUILD_TOOLS_VERSION 1.0.0)

include(ExternalProject)

ExternalProject_Add(
        build-tools

        PREFIX build-tools
        #        DOWNLOAD_COMMAND ""
        #        SOURCE_DIR ../../build-tools
        GIT_REPOSITORY https://github.com/tonystone/build-tools.git
        GIT_TAG ${BUILD_TOOLS_VERSION}
        UPDATE_COMMAND ""  # Note: since there is no update step, installing the tools will only happen once even if you change the version.  To force install, remove the external/build-tools directory.
        CMAKE_CACHE_ARGS
            -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
        EXCLUDE_FROM_ALL true
)

#
# Build tool paths.
#
set(BUILD_TOOLS_ROOT  "${CMAKE_CURRENT_BINARY_DIR}/build-tools/build-tools")
set(BUILD_TOOLS_BIN   "${BUILD_TOOLS_ROOT}/bin")

# Look for modules in the our root.
LIST(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR})

include(Gyb)

#
# Clean the sticky package
#
add_custom_target(geofeatures-build-clean
        COMMAND swift package clean
        WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
        )

#
# Build xcode project Target
#
add_custom_target(geofeatures-xcode-project
        COMMAND swift package generate-xcodeproj --enable-code-coverage
        WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
        SOURCES Package.swift)

add_subdirectory(Sources)
add_subdirectory(Tests)