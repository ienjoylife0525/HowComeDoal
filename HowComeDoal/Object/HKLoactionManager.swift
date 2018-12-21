//
//  HKLoactionManager.swift
//  HowComeDoal
//
//  Created by Patato on 2018/12/20.
//  Copyright © 2018 Patato. All rights reserved.
//

import Foundation
import CoreLocation

class HKLocationManager: NSObject {
    
    private var m_locationManager: CLLocationManager?
    private var m_currentLocation: CLLocationCoordinate2D?
    static let shared = HKLocationManager()
    private var m_passLocation: ((CLLocationCoordinate2D) -> Void)?
    
    private override init() {
        super.init()
        m_locationManager = CLLocationManager()
        m_locationManager?.delegate = self
        m_locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        m_locationManager?.distanceFilter = kCLLocationAccuracyHundredMeters
        m_locationManager?.requestAlwaysAuthorization()
    }
    
    func startUpdatingLocation() {
        m_locationManager?.startUpdatingLocation()
    }
    
    func stopUpdatingLoction() {
        m_locationManager?.stopUpdatingLocation()
    }
    
    func getLocation(location:@escaping (CLLocationCoordinate2D) -> Void) {
        m_locationManager?.startUpdatingLocation()
        m_passLocation = location
    }
    
}

extension HKLocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        m_locationManager?.stopUpdatingLocation()
        if let location = locations.last {
            m_currentLocation = location.coordinate
            m_passLocation?(location.coordinate)
            m_passLocation = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager Error: \(error)")
    }
}
