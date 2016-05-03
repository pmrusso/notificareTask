import MapKit

class MapViewDelegate: NSObject, MKMapViewDelegate {
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {        
        assert((overlay as? MKCircle) != nil)
        
        let circleRenderer = MKCircleRenderer(circle: overlay as! MKCircle)
        circleRenderer.fillColor = UIColor.blueColor().colorWithAlphaComponent(0.3)
        return circleRenderer
    }
}
