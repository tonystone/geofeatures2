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
add_custom_target(build ALL
        COMMAND swift build
        BYPRODUCTS .build
        SOURCES ${SOURCE_FILES}
        WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
        )

#
# We use gyb for many files, these commands define how to build those.
#
set(GYB_COMMON_FLAGS --line-directive "''")

#
# GeoFeatures
#
add_gyb_target(generate-LinearRing
        SOURCE GeoFeatures/CoordinateCollectionTypes.swift.gyb
        OUTPUT GeoFeatures/LinearRing.swift
        FLAGS ${GYB_COMMON_FLAGS} -D Self=LinearRing
        DEPENDS GeoFeatures/CoordinateCollectionTypes.swift.gyb build-tools
        )

add_gyb_target(generate-LineString
        SOURCE GeoFeatures/CoordinateCollectionTypes.swift.gyb
        OUTPUT GeoFeatures/LineString.swift
        FLAGS ${GYB_COMMON_FLAGS} -D Self=LineString
        DEPENDS GeoFeatures/CoordinateCollectionTypes.swift.gyb build-tools
        )

add_gyb_target(generate-GeometryCollection
        SOURCE GeoFeatures/GeometryCollectionTypes.swift.gyb
        OUTPUT GeoFeatures/GeometryCollection.swift
        FLAGS ${GYB_COMMON_FLAGS} -D Self=GeometryCollection -D Element=Geometry
        DEPENDS GeoFeatures/GeometryCollectionTypes.swift.gyb build-tools
        )

add_gyb_target(generate-MultiPoint
        SOURCE GeoFeatures/GeometryCollectionTypes.swift.gyb
        OUTPUT GeoFeatures/MultiPoint.swift
        FLAGS ${GYB_COMMON_FLAGS} -D Self=MultiPoint -D Element=Point
        DEPENDS GeoFeatures/GeometryCollectionTypes.swift.gyb build-tools
        )

add_gyb_target(generate-MultiLineString
        SOURCE GeoFeatures/GeometryCollectionTypes.swift.gyb
        OUTPUT GeoFeatures/MultiLineString.swift
        FLAGS ${GYB_COMMON_FLAGS} -D Self=MultiLineString -D Element=LineString
        DEPENDS GeoFeatures/GeometryCollectionTypes.swift.gyb build-tools
        )

add_gyb_target(generate-MultiPolygon
        SOURCE GeoFeatures/GeometryCollectionTypes.swift.gyb
        OUTPUT GeoFeatures/MultiPolygon.swift
        FLAGS ${GYB_COMMON_FLAGS} -D Self=MultiPolygon -D Element=Polygon
        DEPENDS GeoFeatures/GeometryCollectionTypes.swift.gyb build-tools
        )

#
# GeoFeaturesPlaygroundSupport
#
add_gyb_target(generate-GeoFeatures-CustomPlaygroundDisplayConvertible
        SOURCE GeoFeaturesPlaygroundSupport/GeoFeatures+CustomPlaygroundDisplayConvertible.swift.gyb
        OUTPUT GeoFeaturesPlaygroundSupport/GeoFeatures+CustomPlaygroundDisplayConvertible.swift
        FLAGS ${GYB_COMMON_FLAGS}
        DEPENDS build-tools
        )

add_custom_target(generate-source
        DEPENDS generate-LinearRing generate-LineString generate-GeometryCollection generate-MultiPoint generate-MultiLineString generate-MultiPolygon generate-GeoFeatures-CustomPlaygroundDisplayConvertible
        )

add_dependencies(build generate-source)
