//
//  MapViewController.swift
//  Supplment Bazar
//
//  Created by Ameer on 06/06/2021.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController {

    var location: CLLocationCoordinate2D?
    var placeName: String?
    var locationAction: ((CLLocationCoordinate2D?, String) -> ())?
    
    fileprivate let confirmButton: DizneyButton = {
        let confirmButton = DizneyButton()
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.setTitle(title: "Confirm")
        return confirmButton
    }()
    
    fileprivate let marker = GMSMarker()
    fileprivate var camera = GMSCameraPosition()
    fileprivate let mapDialog = MapDialog()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        camera = GMSCameraPosition.camera(withTarget: CLLocationCoordinate2D(latitude: 33.33333, longitude: 44.343443), zoom: 10.0)
        let mapView = GMSMapView.map(withFrame: self.view.bounds, camera: camera)
        self.view.addSubview(mapView)
        mapView.delegate = self
        
        if let location = location {
            let marker = GMSMarker()
            marker.position = location
            marker.title = "Baghdad"
            marker.snippet = "Iraq"
            marker.map = mapView
        }
        
        view.addSubview(mapView)
        let cancel = UIButton()
        cancel.translatesAutoresizingMaskIntoConstraints = false
        cancel.setImage(#imageLiteral(resourceName: "back button"), for: .normal)
        cancel.tintColor = UIColor.textPrimary
        cancel.addTarget(self, action: #selector(handleCancelButton), for: .touchUpInside)
        view.addSubview(cancel)
        
        view.addSubview(confirmButton)
        NSLayoutConstraint.activate([
            cancel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            cancel.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            cancel.heightAnchor.constraint(equalToConstant: 36),
            cancel.widthAnchor.constraint(equalToConstant: 36),
            
            confirmButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            confirmButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        confirmButton.addTarget(self, action: #selector(handleConfirmButton), for: .touchUpInside)
        
        view.addSubview(mapDialog)
        mapDialog.addToView(view: view)
        mapDialog.hideView()
    }
    
    @objc fileprivate func handleConfirmButton() {
        if let location = location, let placeName = placeName, let action = locationAction {
            action(location, placeName)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc fileprivate func handleCancelButton() {
        dismiss(animated: true, completion: nil)
    }

}

extension MapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        self.location = coordinate
        camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: mapView.camera.zoom)
        marker.position = coordinate
        marker.icon = GMSMarker.markerImage(with: .primary)
        marker.map = mapView
        
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if error != nil {
                print("reverse geodcode fail: \(error!.localizedDescription)")
            } else {
                if let places = response?.results() {
                    print("all lines", places)
                    if let place = places.first {
                        if let lines = place.lines {
                            self.placeName = lines[0]
                            self.mapDialog.setLocation(messgae: lines[0])
                            self.mapDialog.show()
                        }
                    } else {
                        self.mapDialog.hideView()
                    }
                } else {
                    self.mapDialog.hideView()
                }
            }
        }
    }
}
