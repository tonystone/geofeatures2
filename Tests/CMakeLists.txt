#
# For Swift Package Manager, all output files placed in the package directories must be saved.  These include the output from gyb and LinuxMain.swift.
#
set_directory_properties(PROPERTIES CLEAN_NO_CUSTOM 1)

file(GLOB_RECURSE TEST_FILES  *.swift)
file(GLOB_RECURSE TEST_GYB    *.gyb)
file(GLOB LINUX_MAIN LinuxMain.swift)

#
# Remove LinuxMain.swift from the list as this will be handled separately if Linux.
#
list(REMOVE_ITEM TEST_FILES "${LINUX_MAIN}")

#
# Test Target
#
add_custom_target(geofeatures-test
        COMMAND swift test
        DEPENDS geofeatures-build
        SOURCES ${TEST_FILES} ${TEST_GYB}
        WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
        )

#add_gyb_targets("${TEST_GYB}"  geofeatures-tests)
add_gyb_target(generated-LinearRingTests
        SOURCE ${CMAKE_SOURCE_DIR}/Tests/GeoFeaturesTests/CoordinateCollectionTests.swift.gyb
        OUTPUT ${CMAKE_SOURCE_DIR}/Tests/GeoFeaturesTests/LinearRingTests.swift
        FLAGS -D GeometryType=LinearRing -D FileName=LinearRing.swift
        DEPENDS build-tools
        )

add_gyb_target(generated-LineStringTests
        SOURCE ${CMAKE_SOURCE_DIR}/Tests/GeoFeaturesTests/CoordinateCollectionTests.swift.gyb
        OUTPUT ${CMAKE_SOURCE_DIR}/Tests/GeoFeaturesTests/LineStringTests.swift
        FLAGS -D GeometryType=LineString -D FileName=LineString.swift
        DEPENDS build-tools
        )

add_gyb_target(generated-GeometryCollectionTests
        SOURCE ${CMAKE_SOURCE_DIR}/Tests/GeoFeaturesTests/GeometryCollectionTests.swift.gyb
        OUTPUT ${CMAKE_SOURCE_DIR}/Tests/GeoFeaturesTests/GeometryCollectionTests.swift
        FLAGS -D TestInput='GeometryCollectionTestInput'
        DEPENDS build-tools
        )

add_gyb_target(generated-MultiPointTests
        SOURCE ${CMAKE_SOURCE_DIR}/Tests/GeoFeaturesTests/GeometryCollectionTests.swift.gyb
        OUTPUT ${CMAKE_SOURCE_DIR}/Tests/GeoFeaturesTests/MultiPointTests.swift
        FLAGS -D TestInput='MultiPointTestInput'
        DEPENDS build-tools
        )

add_gyb_target(generated-MultiLineStringTests
        SOURCE ${CMAKE_SOURCE_DIR}/Tests/GeoFeaturesTests/GeometryCollectionTests.swift.gyb
        OUTPUT ${CMAKE_SOURCE_DIR}/Tests/GeoFeaturesTests/MultiLineStringTests.swift
        FLAGS -D TestInput='MultiLineStringTestInput'
        DEPENDS build-tools
        )

add_gyb_target(generated-MultiPolygonTests
        SOURCE ${CMAKE_SOURCE_DIR}/Tests/GeoFeaturesTests/GeometryCollectionTests.swift.gyb
        OUTPUT ${CMAKE_SOURCE_DIR}/Tests/GeoFeaturesTests/MultiPolygonTests.swift
        FLAGS -D TestInput='MultiPolygonTestInput'
        DEPENDS build-tools
        )

add_dependencies(geofeatures-test generated-LineStringTests generated-LineStringTests generated-GeometryCollectionTests generated-MultiPointTests generated-MultiLineStringTests generated-MultiPolygonTests)

if(UNIX AND NOT APPLE)

    add_custom_command(
            DEPENDS ${TEST_FILES} build-tools
            OUTPUT "${LINUX_MAIN}"
            COMMAND "${LINUXMAINTOOL}"
            ARGS --package-path "${CMAKE_SOURCE_DIR}"
            VERBATIM
    )

    add_custom_target(linux-main
            DEPENDS "${LINUX_MAIN}"
            )
    add_dependencies(geofeatures-test linux-main)

endif()
