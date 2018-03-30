GeometryClass         = 'MultiLineString'
GeometryIsGeneric     = True
GeometryElementType   = GeometryClass + '.Element'
ElementCast           = ''
ElementArrayCast      = ''

Variants = [
            ('Coordinate2D', 'FloatingPrecision', '()', 'Cartesian', '()',
             # Test Values 1
             'LineString(coordinates: [[0.0, 0.0], [0.0, 2.0], [0.0, 3.0], [2.0, 0.0], [0.0, 0.0]])',
             'LineString(coordinates: [[0.0, 0.0], [0.0, 2.0], [0.0, 3.0], [2.0, 0.0], [0.0, 0.0]])',
             'LineString((x: 0.0, y: 0.0), (x: 0.0, y: 2.0), (x: 0.0, y: 3.0), (x: 2.0, y: 0.0), (x: 0.0, y: 0.0))',
             # Test Values 2
             'LineString(coordinates: [[0.0, 1.0], [0.0, 2.0], [0.0, 3.0], [2.0, 0.0], [0.0, 1.0]])',
             'LineString(coordinates: [[0.0, 1.0], [0.0, 2.0], [0.0, 3.0], [2.0, 0.0], [0.0, 1.0]])',
             'LineString((x: 0.0, y: 1.0), (x: 0.0, y: 2.0), (x: 0.0, y: 3.0), (x: 2.0, y: 0.0), (x: 0.0, y: 1.0))'
             ),

            ('Coordinate2D', 'FixedPrecision', '(scale: 100)', 'Cartesian', '()',
             # Test Values 1
             'LineString(coordinates: [[0.0, 0.0], [0.0, 2.002], [0.0, 3.003], [2.002, 0.0], [0.0, 0.0]])',
             'LineString(coordinates: [[0.0, 0.0], [0.0, 2.0], [0.0, 3.0], [2.0, 0.0], [0.0, 0.0]])',
             'LineString((x: 0.0, y: 0.0), (x: 0.0, y: 2.0), (x: 0.0, y: 3.0), (x: 2.0, y: 0.0), (x: 0.0, y: 0.0))',
             # Test Values 2
             'LineString(coordinates: [[0.0, 1.001], [0.0, 2.002], [0.0, 3.003], [2.002, 0.0], [0.0, 1.001]])',
             'LineString(coordinates: [[0.0, 1.0], [0.0, 2.0], [0.0, 3.0], [2.0, 0.0], [0.0, 1.0]])',
             'LineString((x: 0.0, y: 1.0), (x: 0.0, y: 2.0), (x: 0.0, y: 3.0), (x: 2.0, y: 0.0), (x: 0.0, y: 1.0))'
             ),
            ]
