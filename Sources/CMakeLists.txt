#
# For Swift Package Manager, all output files placed in the package directories must be saved.  These include the output from gyb.
#
set_directory_properties(PROPERTIES CLEAN_NO_CUSTOM 1)

#
# Build the list of sources dynamically.
#
file(GLOB_RECURSE SOURCE_FILES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.swift Package.swift )

#
# Main Build Target
#
add_custom_target(geofeatures-build ALL
        COMMAND swift build
        BYPRODUCTS .build
        SOURCES ${SOURCE_FILES}
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        )

#
# We use gyb for many files, these commands define how to build those.
#
set(GYB_COMMON_FLAGS --line-directive "''")

add_gyb_target(generated-LinearRing
        SOURCE GeoFeatures/CoordinateCollection.swift.gyb
        OUTPUT GeoFeatures/LinearRing.swift
        FLAGS ${GYB_COMMON_FLAGS} -D Self=LinearRing
        DEPENDS build-tools
        )

add_gyb_target(generated-LineString
        SOURCE GeoFeatures/CoordinateCollection.swift.gyb
        OUTPUT GeoFeatures/LineString.swift
        FLAGS ${GYB_COMMON_FLAGS} -D Self=LineString
        DEPENDS build-tools
        )

add_gyb_target(generated-GeometryCollection
        SOURCE GeoFeatures/GeometryCollection.swift.gyb
        OUTPUT GeoFeatures/GeometryCollection.swift
        FLAGS ${GYB_COMMON_FLAGS} -D Self=GeometryCollection -D Element=Geometry -D CoordinateSpecialized=false
        DEPENDS build-tools
        )

add_gyb_target(generated-MultiPoint
        SOURCE GeoFeatures/GeometryCollection.swift.gyb
        OUTPUT GeoFeatures/MultiPoint.swift
        FLAGS ${GYB_COMMON_FLAGS} -D Self=MultiPoint -D Element=Point -D CoordinateSpecialized=true
        DEPENDS build-tools
        )

add_gyb_target(generated-MultiLineString
        SOURCE GeoFeatures/GeometryCollection.swift.gyb
        OUTPUT GeoFeatures/MultiLineString.swift
        FLAGS ${GYB_COMMON_FLAGS} -D Self=MultiLineString -D Element=LineString -D CoordinateSpecialized=true
        DEPENDS build-tools
        )

add_gyb_target(generated-MultiPolygon
        SOURCE GeoFeatures/GeometryCollection.swift.gyb
        OUTPUT GeoFeatures/MultiPolygon.swift
        FLAGS ${GYB_COMMON_FLAGS} -D Self=MultiPolygon -D Element=Polygon -D CoordinateSpecialized=true
        DEPENDS build-tools
        )

add_dependencies(geofeatures-build generated-LinearRing generated-LineString generated-GeometryCollection generated-MultiPoint generated-MultiLineString generated-MultiPolygon)
