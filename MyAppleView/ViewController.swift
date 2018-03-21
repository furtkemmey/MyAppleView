//
//  ViewController.swift
//  MyAppleView
//
//  Created by KaiChieh on 21/03/2018.
//  Copyright © 2018 KaiChieh. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    let localManager = CLLocationManager()

    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        localManager.requestAlwaysAuthorization()
        localManager.delegate = self
        mapView.delegate = self
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 24.137426, longitude: 121.275753)
        annotation.title = "武嶺"
        annotation.subtitle = "仁愛鄉"
        mapView.showsUserLocation = true
        mapView.addAnnotation(annotation)
        mapView.setCenter(annotation.coordinate, animated: false)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        localManager.startUpdatingLocation()
    }
}
extension ViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        <#code#>
    }

}

