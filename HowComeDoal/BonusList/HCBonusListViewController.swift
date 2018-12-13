//
//  HCBonusListViewController.swift
//  HowComeDoal
//
//  Created by Patato on 2018/12/11.
//  Copyright © 2018 Patato. All rights reserved.
//

import UIKit
import CoreLocation

enum BonusType: Int {
    case card
    case location
}



class HCBonusListViewController: UIViewController {

    var m_ibonusType: BonusType = .card
    var m_aryParameter = [(String, String)]()
    var m_data: Data?
    var m_bonusList: ResponseList?
    var m_location: CLLocationManager!
    var m_strLongitude: String?
    var m_strLatitude: String?

    @IBOutlet weak var m_tvBonusList: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocation()
        
        let nib = UINib(nibName: "HCBonusListTableViewCell", bundle: nil)
        
        m_tvBonusList?.register(nib, forCellReuseIdentifier: "BonusListCell")
        m_tvBonusList?.dataSource = self
        m_tvBonusList?.dataSource = self
    }
    
    private func decode() {
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(ResponseList.self, from: self.m_data!)
            m_bonusList = response
            
        } catch {
            print("error")
        }
    }
    
    private func setLocation() {
        m_location = CLLocationManager()
        m_location.delegate = self
        m_location.requestWhenInUseAuthorization()
        m_location.activityType = .automotiveNavigation
        m_location.startUpdatingLocation()
    }
    
    private func callWebService() {
        m_aryParameter.append(("appId", k_iAppId))
        switch m_ibonusType {
        case .card:
            m_aryParameter.append(("dataGroupCode", k_iDataGroupCard))
        case .location:
            m_aryParameter.append(("dataGroupCode", k_iDataGroupLocation))
        }
        m_aryParameter.append(("index", "0"))
        m_aryParameter.append(("limit", "30"))
        m_aryParameter.append(("OS", "IOS"))
        m_aryParameter.append(("lat", m_strLatitude!))
        m_aryParameter.append(("lon", m_strLongitude!))
        
        HttpClient().requestWithURL(urlString: k_strURL, parameters: m_aryParameter) { (data) in
            self.m_data = data
            print(data)
            self.decode()
            DispatchQueue.main.async {
                self.m_tvBonusList?.reloadData()
            }
        }
        
    }


}

extension HCBonusListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = m_bonusList?.branch.count else {
            return 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = m_tvBonusList?.dequeueReusableCell(withIdentifier: "BonusListCell", for: indexPath) as! HCBonusListTableViewCell
        
        cell.m_lbTitle?.text = m_bonusList?.branch[indexPath.item].name
        guard let url = URL(string: (m_bonusList?.branch[indexPath.item].logo)!) else {
            return cell
        }
        let data = try? Data(contentsOf: url)
        cell.m_ivmgIcon?.image = UIImage(data: data!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}

extension HCBonusListViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        m_location.stopUpdatingLocation()
        let current = locations.last
        guard let lat = current?.coordinate.latitude else {
            return
        }
        m_strLatitude = "\(lat)"
        guard let lon = current?.coordinate.longitude else {
            return
        }
        m_strLongitude = "\(lon)"
        
        callWebService()
        
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
