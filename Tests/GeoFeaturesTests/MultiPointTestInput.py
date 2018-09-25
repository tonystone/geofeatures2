GeometryClass         = 'MultiPoint'
GeometryIsGeneric     = True
GeometryElementType   = GeometryClass + '.Element'
ElementCast           = ''
ElementArrayCast      = ''

Variants = [
            ('Coordinate2D', 'FloatingPrecision', '()', 'Cartesian', '()',
                'Point([1.0, 1.0])',
                'Point([1.0, 1.0])',
                'Point(x: 1.0, y: 1.0)',

                'Point([2.0, 2.0])',
                'Point([2.0, 2.0])',
                'Point(x: 2.0, y: 2.0)'
                ),

            ('Coordinate2D', 'Fixed', '(scale: 100)', 'Cartesian', '()',
                'Point([1.001, 1.001])',
                'Point([1.0, 1.0])',
                'Point(x: 1.0, y: 1.0)',

                'Point([2.002, 2.002])',
                'Point([2.0, 2.0])',
                'Point(x: 2.0, y: 2.0)'
                ),
            ]
