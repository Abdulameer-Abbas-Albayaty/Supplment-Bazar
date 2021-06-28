//
//  LocationSVD.swift
//  Supplment Bazar
//
//  Created by Ameer on 06/06/2021.
//

import Foundation
import CoreLocation

protocol LocationSVD : AnyObject {
    func locationFetchedSuccessfully(location : CLLocationCoordinate2D)
    func unauthorizedLocationAccess()
    func failedFetchingLocation()
}

//// delegatign class
final class LocationService : NSObject, CLLocationManagerDelegate {
    
    /// properties
    private let locationMannager = CLLocationManager()
    weak var delegate : LocationSVD?
    
    override init() {
        super.init()
        locationMannager.delegate = self
    }
    
    public func startUpdatingLocation(withDistanceFilter filter : CLLocationDistance = 30) {
        locationMannager.requestAlwaysAuthorization()
        locationMannager.desiredAccuracy = kCLLocationAccuracyBest
        locationMannager.distanceFilter = filter
        locationMannager.startUpdatingLocation()
    }

    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else {return}
        delegate?.locationFetchedSuccessfully(location: lastLocation.coordinate)
        locationMannager.stopUpdatingLocation()
        locationMannager.delegate = nil
    }
    
    internal func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:      self.delegate?.unauthorizedLocationAccess()
            default:                                        self.delegate?.failedFetchingLocation()
            }
        }
    }
}
