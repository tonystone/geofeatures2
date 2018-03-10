#
# For Swift Package Manager, all output files placed in the package directories must be saved.  These include the output from gyb.
#
set_directory_properties(PROPERTIES CLEAN_NO_CUSTOM 1)

#
# Build the list of sources dynamically.
#
file(GLOB_RECURSE SOURCE_FILES *.swift Package.swift)

#
# Main Build Target
#
add_custom_target(geofeatures-build
        COMMAND swift build
        BYPRODUCTS .build
        SOURCES ${SOURCE_FILES}
        WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
        )

#
# We use gyb for many files, these commands define how to build those.
#
add_gyb_target(generated-LinearRing
        SOURCE ${CMAKE_SOURCE_DIR}/Sources/GeoFeatures/CoordinateCollection.swift.gyb
        OUTPUT ${CMAKE_SOURCE_DIR}/Sources/GeoFeatures/LinearRing.swift
        FLAGS -D Self=LinearRing
        DEPENDS build-tools
        )

add_gyb_target(generated-LineString
        SOURCE ${CMAKE_SOURCE_DIR}/Sources/GeoFeatures/CoordinateCollection.swift.gyb
        OUTPUT ${CMAKE_SOURCE_DIR}/Sources/GeoFeatures/LineString.swift
        FLAGS -D Self=LineString
        DEPENDS build-tools
        )

add_gyb_target(generated-GeometryCollection
        SOURCE ${CMAKE_SOURCE_DIR}/Sources/GeoFeatures/GeometryCollection.swift.gyb
        OUTPUT ${CMAKE_SOURCE_DIR}/Sources/GeoFeatures/GeometryCollection.swift
        FLAGS -D Self=GeometryCollection -D Element=Geometry -D CoordinateSpecialized=false
        DEPENDS build-tools
        )

add_gyb_target(generated-MultiPoint
        SOURCE ${CMAKE_SOURCE_DIR}/Sources/GeoFeatures/GeometryCollection.swift.gyb
        OUTPUT ${CMAKE_SOURCE_DIR}/Sources/GeoFeatures/MultiPoint.swift
        FLAGS -D Self=MultiPoint -D Element=Point -D CoordinateSpecialized=true
        DEPENDS build-tools
        )

add_gyb_target(generated-MultiLineString
        SOURCE ${CMAKE_SOURCE_DIR}/Sources/GeoFeatures/GeometryCollection.swift.gyb
        OUTPUT ${CMAKE_SOURCE_DIR}/Sources/GeoFeatures/MultiLineString.swift
        FLAGS -D Self=MultiLineString -D Element=LineString -D CoordinateSpecialized=true
        DEPENDS build-tools
        )

add_gyb_target(generated-MultiPolygon
        SOURCE ${CMAKE_SOURCE_DIR}/Sources/GeoFeatures/GeometryCollection.swift.gyb
        OUTPUT ${CMAKE_SOURCE_DIR}/Sources/GeoFeatures/MultiPolygon.swift
        FLAGS -D Self=MultiPolygon -D Element=Polygon -D CoordinateSpecialized=true
        DEPENDS build-tools
        )

add_dependencies(geofeatures-build generated-LineString generated-LineString generated-GeometryCollection generated-MultiPoint generated-MultiLineString generated-MultiPolygon)
