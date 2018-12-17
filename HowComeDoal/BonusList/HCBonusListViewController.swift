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
    var m_locationManager: CLLocationManager!
    var m_strLongitude: String?
    var m_strLatitude: String?
    var m_branchs = [Branch]()
    var m_iLoadFrom: Int = 1
    var m_iLoadEnd: Int = 30
    var m_iLoadRange: Int = 30
    var m_bSendRequest: Bool = false
    
    @IBOutlet weak var m_tvBonusList: UITableView?
    @IBOutlet weak var m_vLoadingView: UIView?
    @IBOutlet weak var m_avLoading: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        m_avLoading?.startAnimating()
        setLocation()
        
        let nib = UINib(nibName: "HCBonusListTableViewCell", bundle: nil)
        
        m_tvBonusList?.register(nib, forCellReuseIdentifier: "BonusListCell")
        m_tvBonusList?.dataSource = self
        m_tvBonusList?.delegate = self
        
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
        m_locationManager = CLLocationManager()
        m_locationManager.delegate = self
        m_locationManager.requestWhenInUseAuthorization()
        m_locationManager.activityType = .automotiveNavigation
        m_locationManager.startUpdatingLocation()
    }
    
    private func callWebService(from: Int, to: Int) {

        m_aryParameter.append(("appId", k_iAppId))
        switch m_ibonusType {
        case .card:
            m_aryParameter.append(("dataGroupCode", k_iDataGroupCard))
        case .location:
            m_aryParameter.append(("dataGroupCode", k_iDataGroupLocation))
        }
        m_aryParameter.append(("index", String(from)))
        m_aryParameter.append(("limit", String(to)))
        m_aryParameter.append(("OS", "IOS"))
        m_aryParameter.append(("lat", m_strLatitude!))
        m_aryParameter.append(("lon", m_strLongitude!))
        m_bSendRequest = true
        print("Send request \(from) ~ \(to)")
        HttpClient().requestWithURL(urlString: k_strURL, parameters: m_aryParameter) { (data) in
            DispatchQueue.main.sync {
                self.m_data = data
                print("Data back!! \(data)")
                self.decode()
                if self.m_iLoadEnd > self.m_branchs.count {
                    self.m_branchs += (self.m_bonusList?.branch)!
                }
                self.m_tvBonusList?.reloadData()
                
                self.m_vLoadingView?.isHidden = true
                self.m_avLoading?.stopAnimating()
                self.m_avLoading?.isHidden = true
            }
            self.m_bSendRequest = false
        }
            
        
    }


}

extension HCBonusListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = m_branchs.count
        print(count)
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = m_tvBonusList?.dequeueReusableCell(withIdentifier: "BonusListCell", for: indexPath) as! HCBonusListTableViewCell
        cell.m_lbTitle?.text = m_branchs[indexPath.item].name
        if m_branchs[indexPath.item].logo != "" {
            let url = URL(string: m_branchs[indexPath.item].logo)
            let data = try? Data(contentsOf: url!)
            cell.m_ivmgIcon?.image = UIImage(data: data!)
        } else {
            cell.m_ivmgIcon?.image = UIImage(named: "defaultIcon")
        }
        
        print("\(indexPath.row) + \(m_branchs[indexPath.row].name)")
        if m_bSendRequest == false {
            if indexPath.item + 1 == m_branchs.count - m_iLoadRange / 2 {
                m_iLoadFrom += m_iLoadRange
                m_iLoadEnd += m_iLoadRange
                callWebService(from: m_iLoadFrom, to: m_iLoadRange)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(k_iCellHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventPage = HCEventListViewController()
        if m_branchs[indexPath.item].logo != "" {
            let url = URL(string: m_branchs[indexPath.item].logo)
            let data = try? Data(contentsOf: url!)
            eventPage.m_imgIcon = UIImage(data: data!)!
        } else {
            eventPage.m_imgIcon = UIImage(named: "defaultIcon")
        }
        eventPage.m_Branch = m_branchs[indexPath.item]
        print(indexPath.row)
        print(indexPath.item)
        self.navigationController?.pushViewController(eventPage, animated: true)
    }
    
}



extension HCBonusListViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        m_locationManager.stopUpdatingLocation()

        guard let location = locations.last else {
            return
        }
        m_strLatitude = String(location.coordinate.latitude)
        m_strLongitude = String(location.coordinate.longitude)
        if m_bSendRequest == false {
           callWebService(from: m_iLoadFrom, to: m_iLoadEnd)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
