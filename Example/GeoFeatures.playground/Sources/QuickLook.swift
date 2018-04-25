import Foundation
import MapKit
import PlaygroundSupport
import GeoFeatures


protocol QuickLookable: CustomPlaygroundQuickLookable {
    var mapRect: MKMapRect { get }
    func drawInSnapshot(_ snapshot: MKMapSnapshot, mapRect: MKMapRect)
}

protocol Renderable: QuickLookable {
    var renderer: MKOverlayRenderer { get }
}

let mapPadding = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)

// MARK: - CustomPlaygroundQuickLookable conformance
extension QuickLookable {

    public var customPlaygroundQuickLook: PlaygroundQuickLook {
        let mapView = MKMapView()

        mapView.mapType = .standard
        mapView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)

        let mapRect = self.mapRect
        guard !MKMapRectIsNull(mapRect) else { return .text(String(describing: self)) }

        let paddedRect = mapView.mapRectThatFits(mapRect, edgePadding: mapPadding)
        mapView.setVisibleMapRect(paddedRect, animated: false)

        let options = MKMapSnapshotOptions()
        options.region = mapView.region
        options.scale = UIScreen.main.scale
        options.size = mapView.frame.size

        var mapViewImage: UIImage?
        let qualityOfServiceClass: DispatchQoS.QoSClass = .background
        let backgroundQueue: DispatchQueue = .global(qos: qualityOfServiceClass)
        let snapshotter = MKMapSnapshotter(options: options)
        let semaphore = DispatchSemaphore(value: 0)
        let visibleMapRect = mapView.visibleMapRect

        snapshotter.start(with: backgroundQueue) { snapshot, error in
            defer { semaphore.signal() }
            guard let snapshot = snapshot else { return }
            let image = snapshot.image

            UIGraphicsBeginImageContextWithOptions(image.size, true, image.scale)
            image.draw(at: .zero)

            guard let context = UIGraphicsGetCurrentContext() else {
                fatalError("Could not get current context")
            }
            let scaleX = image.size.width / CGFloat(visibleMapRect.size.width)
            let scaleY = image.size.height / CGFloat(visibleMapRect.size.height)
            context.scaleBy(x: scaleX, y: scaleY)
            self.drawInSnapshot(snapshot, mapRect: visibleMapRect)
            let finalImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            mapViewImage = finalImage
        }
        let delayTime = DispatchTime.now() + Double(Int64(3 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        let _ = semaphore.wait(timeout: delayTime)

        guard let image = mapViewImage else { return .text(String(describing: self)) }
        return .image(image)
    }

}

extension Renderable {

    func drawInSnapshot(_ snapshot: MKMapSnapshot, mapRect: MKMapRect) {
        let zoomScale = snapshot.image.size.width / CGFloat(mapRect.size.width)

        let renderer = self.renderer

        if let context = UIGraphicsGetCurrentContext() {
            context.saveGState()
            let upperCorner = renderer.mapPoint(for: .zero)
            context.translateBy(x: CGFloat(upperCorner.x - mapRect.origin.x), y: CGFloat(upperCorner.y - mapRect.origin.y))
            renderer.draw(mapRect, zoomScale: zoomScale, in: context)
            context.restoreGState()
        }
    }

}


extension CLLocationCoordinate2D {

    init(with point: Point<Coordinate2D>) {
        self.init(latitude: point.y, longitude: point.x)
    }

    init(with coordinate: Coordinate2D) {
        self.init(latitude: coordinate.y, longitude: coordinate.x)
    }

}


extension LinearRing: Renderable {

    public var coordinates: [CLLocationCoordinate2D] {
        guard let s = self as? LinearRing<Coordinate2D> else { return [] }
        return s.flatMap({ CLLocationCoordinate2D(with: $0) })
    }

    public var polygon: MKPolygon {
        let coordinates = self.coordinates
        return MKPolygon(coordinates: coordinates, count: coordinates.count, interiorPolygons: nil)
    }

    var overlay: MKOverlay {
        return self.polygon
    }

    public var mapRect: MKMapRect {
        let coordinates = self.coordinates
        return coordinates.map({ MKMapPointForCoordinate($0) }).map({ MKMapRect(origin: $0, size: MKMapSize(width: 0, height: 0)) }).reduce(MKMapRectNull, MKMapRectUnion)
    }

    var renderer: MKOverlayRenderer {
        let r = MKPolygonRenderer(overlay: self.overlay)
        r.lineWidth = 2
        r.strokeColor = UIColor.blue.withAlphaComponent(0.7)
        r.fillColor = UIColor.cyan.withAlphaComponent(0.2)
        return r
    }

}


extension Polygon: Renderable {

    public var coordinates: [CLLocationCoordinate2D] {
        let ring = self.outerRing as! LinearRing<Coordinate2D>
        let coordinates = ring.flatMap({ CLLocationCoordinate2D(with: $0) })
        return coordinates
    }

    public var overlay: MKOverlay {
        let coordinates = self.coordinates
        let rings = self.innerRings as! [LinearRing<Coordinate2D>]
        let interiorPolygons = rings.map({ $0.polygon })
        return MKPolygon(coordinates: coordinates, count: coordinates.count, interiorPolygons: interiorPolygons)
    }

    public var mapRect: MKMapRect {
        let coordinates = self.coordinates
        return coordinates.map({ MKMapPointForCoordinate($0) }).map({ MKMapRect(origin: $0, size: MKMapSize(width: 0, height: 0)) }).reduce(MKMapRectNull, MKMapRectUnion)
    }

    var renderer: MKOverlayRenderer {
        let r = MKPolygonRenderer(overlay: self.overlay)
        r.lineWidth = 2
        r.strokeColor = UIColor.blue.withAlphaComponent(0.7)
        r.fillColor = UIColor.cyan.withAlphaComponent(0.2)
        return r
    }

}


extension LineString: Renderable {

    public var coordinates: [CLLocationCoordinate2D] {
        guard let s = self as? LineString<Coordinate2D> else { return [] }
        return s.flatMap({ CLLocationCoordinate2D(with: $0) })
    }

    var overlay: MKOverlay {
        let coordinates = self.coordinates
        return MKPolyline(coordinates: coordinates, count: coordinates.count)
    }

    public var mapRect: MKMapRect {
        let coordinates = self.coordinates
        return coordinates.map({ MKMapPointForCoordinate($0) }).map({ MKMapRect(origin: $0, size: MKMapSize(width: 0, height: 0)) }).reduce(MKMapRectNull, MKMapRectUnion)
    }

    var renderer: MKOverlayRenderer {
        let r = MKPolylineRenderer(overlay: self.overlay)
        r.lineWidth = 2
        r.strokeColor = UIColor.blue.withAlphaComponent(0.7)
        return r
    }

}


extension Point: QuickLookable {

    public var coordinate: CLLocationCoordinate2D {
        guard let s = self as? Point<Coordinate2D> else { return kCLLocationCoordinate2DInvalid }
        return CLLocationCoordinate2D(with: s)
    }

    public var mapRect: MKMapRect {
        let origin = MKMapPointForCoordinate(self.coordinate)
        let size = MKMapSize()
        let rect = MKMapRect(origin: origin, size: size)
        let inset = Double(-10 * mapPadding.top)
        return MKMapRectInset(rect, inset, inset)
    }

    func drawInSnapshot(_ snapshot: MKMapSnapshot, mapRect: MKMapRect) {
        let coordinate = self.coordinate
        let image = snapshot.image
        let pin = MKPinAnnotationView(annotation: nil, reuseIdentifier: "")
        if let pinImage = pin.image {
            UIGraphicsBeginImageContextWithOptions(image.size, true, image.scale)
            image.draw(at: CGPoint(x: 0, y: 0))
            let homePoint = snapshot.point(for: coordinate)
            var rect = CGRect(x: 0, y: 0, width: pinImage.size.width, height: pinImage.size.height)
            rect = rect.offsetBy(dx: homePoint.x-rect.size.width/2.0, dy: homePoint.y-rect.size.height)
            pinImage.draw(in: rect)
        }
    }

}


extension QuickLookable where Self: Collection {

    var mapRect: MKMapRect {
        return self.flatMap({ $0 as? QuickLookable })
            .map({ $0.mapRect })
            .reduce(MKMapRectNull, MKMapRectUnion)
    }

    func drawInSnapshot(_ snapshot: MKMapSnapshot, mapRect: MKMapRect) {
        self.flatMap({ $0 as? QuickLookable })
            .forEach { $0.drawInSnapshot(snapshot, mapRect: mapRect) }
    }

}


extension MultiLineString: QuickLookable {}
extension MultiPolygon: QuickLookable {}
