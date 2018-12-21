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
    
    private static var m_Instance: HKLocationManager?
    private var m_locationManager: CLLocationManager?
    private var m_currentLocation: CLLocationCoordinate2D?
    static func shared() -> HKLocationManager {
        if m_Instance == nil {
            m_Instance = HKLocationManager()
        }
        return m_Instance!
    }
    
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
    
    func currentLocation() -> CLLocationCoordinate2D {
        return m_currentLocation!
    }
    
    
}

extension HKLocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            m_currentLocation = location.coordinate
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager Error: \(error)")
    }
}
