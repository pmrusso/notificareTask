import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView?
    private var overlays: [MKCircle]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.handleUpdatedRegionsNotification), name: UpdateRegionsNotificationKey, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    func handleUpdatedRegionsNotification() {
        if let overlays = overlays {
            mapView?.removeOverlays(overlays)
        }
        overlays = NotificarePushLib.shared().locationManager.monitoredRegions.map { obj in
            let region = (obj as! CLCircularRegion)
            return MKCircle(centerCoordinate: region.center, radius: region.radius)
        }
        mapView?.addOverlays(overlays!)
    }
}

