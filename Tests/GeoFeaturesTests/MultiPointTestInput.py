GeometryClass         = 'MultiPoint'
GeometryIsGeneric     = True
GeometryElementType   = GeometryClass + '.Element'
ElementCast           = ''
ElementArrayCast      = ''

Variants = [
            ('Coordinate2D', 'FloatingPrecision', '()', 'Cartesian', '()',
                'Point(coordinate: [1.0, 1.0])',
                'Point(coordinate: [1.0, 1.0])',
                'Point(x: 1.0, y: 1.0)',

                'Point(coordinate: [2.0, 2.0])',
                'Point(coordinate: [2.0, 2.0])',
                'Point(x: 2.0, y: 2.0)'
                ),

            ('Coordinate2D', 'FixedPrecision', '(scale: 100)', 'Cartesian', '()',
                'Point(coordinate: [1.001, 1.001])',
                'Point(coordinate: [1.0, 1.0])',
                'Point(x: 1.0, y: 1.0)',

                'Point(coordinate: [2.002, 2.002])',
                'Point(coordinate: [2.0, 2.0])',
                'Point(x: 2.0, y: 2.0)'
                ),
            ]
