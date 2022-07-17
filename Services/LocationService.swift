import Foundation
import CoreLocation

class LocationService: NSObject {
    
    static let shared = LocationService()
    
    let manager = CLLocationManager()
    var completion: (() -> ())?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func getApproval(completion: @escaping() -> ()) {
        manager.requestWhenInUseAuthorization()
        self.completion = completion
    }
    
    func getLocations() -> CLLocation? {
        if CLLocationManager.locationServicesEnabled() {
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.startUpdatingLocation()
        }
        return manager.location
    }
    
    func checkLocation() {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
    
}

extension LocationService: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            self.completion!()
        default:
            break
        }
    }
}
