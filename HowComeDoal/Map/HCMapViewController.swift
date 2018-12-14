//
//  HCMapViewController.swift
//  HowComeDoal
//
//  Created by Patato on 2018/12/14.
//  Copyright © 2018 Patato. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class HCMapViewController: UIViewController {

    @IBOutlet weak var m_lbTitle: UILabel?
    @IBOutlet weak var m_lbAddress: UILabel?
    @IBOutlet weak var m_ivIcon: UIImageView?
    @IBOutlet weak var m_mapView: MKMapView?
    
    var m_aryBranch = [Branch]()
    var m_branch: Branch?
    var m_imgIcon: UIImage?
    
    let m_locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        m_locationManager.delegate = self
        
        m_mapView?.delegate = self
        m_mapView?.showsUserLocation = true
        m_mapView?.userTrackingMode = .follow
        setView()
        setLocation()
        
    }
    
    private func setView() {
        m_ivIcon?.image = m_imgIcon
        m_lbTitle?.text = m_branch?.name
        m_lbAddress?.text = m_branch?.addr
    }
    
    private func setLocation() {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(m_branch!.addr) { (placemarks, error) in
            if error != nil {
                print(error!)
                return
            }
            if let placemarks = placemarks {
                let placemark = placemarks[0]
                let annotation = MKPointAnnotation()
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    self.m_mapView?.addAnnotation(annotation)
                    
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
                    self.m_mapView?.setRegion(region, animated: false)
                }
            }
        }
    }


}

extension HCMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    }
}

extension HCMapViewController: CLLocationManagerDelegate {
    
}
