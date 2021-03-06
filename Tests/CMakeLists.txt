#
# For Swift Package Manager, all output files placed in the package directories must be saved.  These include the output from gyb and LinuxMain.swift.
#
set_directory_properties(PROPERTIES CLEAN_NO_CUSTOM 1)

file(GLOB_RECURSE TEST_FILES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.swift *.gyb)
file(GLOB LINUX_MAIN RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} LinuxMain.swift)

#
# Remove LinuxMain.swift from the list as this will be handled separately if Linux.
#
list(REMOVE_ITEM TEST_FILES "${LINUX_MAIN}")
get_filename_component(LINUX_MAIN ${LINUX_MAIN} ABSOLUTE BASE_DIR ${CMAKE_SOURCE_DIR})

#
# Test Target
#
add_custom_target(tests ALL
        COMMAND swift test
        DEPENDS build
        SOURCES ${TEST_FILES}
        WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
        )

# GYB Targets
set(GYB_COMMON_FLAGS --line-directive "''")

add_gyb_target(generate-LinearRingTests
        SOURCE GeoFeaturesTests/CoordinateCollectionTypesTests.swift.gyb
        OUTPUT GeoFeaturesTests/LinearRingTests.swift
        FLAGS ${GYB_COMMON_FLAGS} -D GeometryType=LinearRing -D FileName=LinearRing.swift
        DEPENDS build-tools
        )

add_gyb_target(generate-LineStringTests
        SOURCE GeoFeaturesTests/CoordinateCollectionTypesTests.swift.gyb
        OUTPUT GeoFeaturesTests/LineStringTests.swift
        FLAGS ${GYB_COMMON_FLAGS} -D GeometryType=LineString -D FileName=LineString.swift
        DEPENDS build-tools
        )

add_gyb_target(generate-GeometryCollectionTests
        SOURCE GeoFeaturesTests/GeometryCollectionTypesTests.swift.gyb
        OUTPUT GeoFeaturesTests/GeometryCollectionTests.swift
        FLAGS ${GYB_COMMON_FLAGS} -D TestInput='GeometryCollectionTestInput'
        DEPENDS GeoFeaturesTests/GeometryCollectionTestInput.py build-tools
        )

add_gyb_target(generate-MultiPointTests
        SOURCE GeoFeaturesTests/GeometryCollectionTypesTests.swift.gyb
        OUTPUT GeoFeaturesTests/MultiPointTests.swift
        FLAGS ${GYB_COMMON_FLAGS} -D TestInput='MultiPointTestInput'
        DEPENDS GeoFeaturesTests/MultiPointTestInput.py build-tools
        )

add_gyb_target(generate-MultiLineStringTests
        SOURCE GeoFeaturesTests/GeometryCollectionTypesTests.swift.gyb
        OUTPUT GeoFeaturesTests/MultiLineStringTests.swift
        FLAGS ${GYB_COMMON_FLAGS} -D TestInput='MultiLineStringTestInput'
        DEPENDS GeoFeaturesTests/MultiLineStringTestInput.py build-tools
        )

add_gyb_target(generate-MultiPolygonTests
        SOURCE GeoFeaturesTests/GeometryCollectionTypesTests.swift.gyb
        OUTPUT GeoFeaturesTests/MultiPolygonTests.swift
        FLAGS ${GYB_COMMON_FLAGS} -D TestInput='MultiPolygonTestInput'
        DEPENDS GeoFeaturesTests/MultiPolygonTestInput.py build-tools
        )

add_custom_target(generate-tests
        DEPENDS generate-LinearRingTests generate-LineStringTests generate-GeometryCollectionTests generate-MultiPointTests generate-MultiLineStringTests generate-MultiPolygonTests
        )

add_dependencies(tests generate-tests)

#
# Build the LinuxMain file.
#
# Note: We do this for all platforms so that we are assured that it is maintained whenever a change is made to the tests.
#
add_custom_command(
        DEPENDS build-tools
        OUTPUT "${LINUX_MAIN}"
        COMMAND "${BUILD_TOOLS_BIN}/xctest_tool.rb"
        ARGS --package-path "${CMAKE_SOURCE_DIR}"
        VERBATIM
)

add_custom_target(linux-main
        DEPENDS "${LINUX_MAIN}" generate-tests
        )
add_dependencies(tests linux-main)
