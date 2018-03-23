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
import SafariServices

class ViewController: UIViewController {
    let localManager = CLLocationManager()

    @IBOutlet weak var lblDirection: UILabel!
    @IBOutlet weak var lblAltitude: UILabel!
    @IBOutlet weak var lblLatitude: UILabel!
    @IBOutlet weak var lblLongtutued: UILabel!
    @IBOutlet weak var mapView: MKMapView!

    // MARK: - Public
//    @objc func calloutButtonPressed (_ sender:UIButton) {
//        if sender.tag == 100 {
//            let url = URL(string: "http://www.taroko.gov.tw")
//            let safari = SFSafariViewController(url: url!)
//            show(safari, sender: self)
//        }
//    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        localManager.requestAlwaysAuthorization()
        localManager.delegate = self
        mapView.delegate = self

        //Make a Annotation
        var annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 24.137426, longitude: 121.275753)
        annotation.title = "武嶺"
        annotation.subtitle = "仁愛鄉"

        mapView.showsUserLocation = true
        mapView.addAnnotation(annotation)
//        mapView.setCenter(annotation.coordinate, animated: false)

        var arrAnnotation = [MKAnnotation]()
        //1st
        annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 23.510041, longitude: 120.700458)
        annotation.title = "奮起湖"
        annotation.subtitle = "嘉義縣竹崎鄉"
        arrAnnotation.append(annotation)

        //2st
        annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 21.948331, longitude: 120.779752)
        annotation.title = "墾丁"
        annotation.subtitle = "屏東縣恆春鄉"
        arrAnnotation.append(annotation)

        mapView.addAnnotations(arrAnnotation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        localManager.startUpdatingLocation()
        localManager.startUpdatingHeading()
    }
    override func viewWillDisappear(_ animated: Bool) {
        localManager.stopUpdatingLocation()
        localManager.stopUpdatingHeading()
    }
}
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let aLocation = locations.first
        lblAltitude.text = String(format: "%.5f", (aLocation?.altitude)!)
        lblLatitude.text = "\(String(describing: aLocation?.coordinate.latitude))"
        lblLongtutued.text = "\(String(describing: aLocation?.coordinate.longitude))"
    }
//    updateHeading
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        print("\(newHeading.magneticHeading)")
        print("\(newHeading.trueHeading)")
        let dblDircetion = newHeading.trueHeading
        if dblDircetion < 0 {
            lblDirection.text = "Unknow"
        } else if dblDircetion >= 0, dblDircetion < 46 {
            lblDirection.text = "NorthEast"
        } else if dblDircetion >= 46, dblDircetion < 91 {
            lblDirection.text = "East"
        } else if dblDircetion >= 91, dblDircetion < 136 {
            lblDirection.text = "SouthEast"
        } else if dblDircetion >= 136, dblDircetion < 181 {
            lblDirection.text = "South"
        } else if dblDircetion >= 181, dblDircetion < 226 {
            lblDirection.text = "SouthWest"
        } else if dblDircetion >= 226, dblDircetion < 271 {
            lblDirection.text = "West"
        } else if dblDircetion >= 226, dblDircetion < 316 {
            lblDirection.text = "NorthWest"
        } else {
            lblDirection.text = "North"
        }
    }
}
extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "Pin") as? MKPinAnnotationView
//        if annotationView == nil {
//            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
//        }
//        if annotation.title! == "武嶺" {
//            annotationView!.pinTintColor = MKPinAnnotationView.greenPinColor()
//            annotationView?.canShowCallout = true
//        }
//        if annotation.title! == "奮起湖" {
//            annotationView!.pinTintColor = UIColor.orange
//            annotationView?.canShowCallout = true
//        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "Pin")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
            annotationView!.image = UIImage(named: "coffee_to_go.png")
            annotationView?.canShowCallout = true
        }
        if annotation.title! == "武嶺" {
            let imageView = UIImageView(image: UIImage(named: "wuling.jpg"))
//            imageView.contentMode = .scaleToFill
//            imageView.clipsToBounds = true
            annotationView?.leftCalloutAccessoryView = imageView // Left callout

            // add label
            let label = UILabel()
            label.numberOfLines = 2
            label.text = "lat: \(annotation.coordinate.latitude)\n lon:\(annotation.coordinate.longitude)"
            annotationView?.detailCalloutAccessoryView = label
            // add button
            let button = UIButton(type: .detailDisclosure)
            button.tag = 100
            button.addTarget(self, action: #selector(calloutButtonPressed(_:)), for: .touchUpInside)
            annotationView?.rightCalloutAccessoryView = button // Right
        }
        return annotationView
    }
    @objc func calloutButtonPressed (_ sender:UIButton) {
        if sender.tag == 100 {
            let url = URL(string: "http://www.taroko.gov.tw")
            let safari = SFSafariViewController(url: url!)
            show(safari, sender: self)
        }
    }
}

