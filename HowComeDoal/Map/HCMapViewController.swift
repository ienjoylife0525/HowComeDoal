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
        
        //Set Home button
        let button = UIButton()
        button.setImage(UIImage(named: "homeBtn"), for: .normal)
        button.addTarget(self, action: #selector(toHome), for: .touchUpInside)
        let m_btnHome = UIBarButtonItem(customView: button)
        let width = m_btnHome.customView?.widthAnchor.constraint(equalToConstant: 25)
        let height = m_btnHome.customView?.heightAnchor.constraint(equalToConstant: 25)
        width?.isActive = true
        height?.isActive = true
        self.navigationItem.setRightBarButton(m_btnHome, animated: true)
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "HCDLogo"))
    }
    
    @objc private func toHome() {
        self.dismiss(animated: true, completion: {})
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func setView() {
        m_ivIcon?.image = m_imgIcon
        m_ivIcon?.layer.cornerRadius = k_cgfCorner
        m_ivIcon?.clipsToBounds = true
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
