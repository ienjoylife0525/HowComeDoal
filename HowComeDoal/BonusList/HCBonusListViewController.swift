//
//  HCBonusListViewController.swift
//  HowComeDoal
//
//  Created by Patato on 2018/12/11.
//  Copyright © 2018 Patato. All rights reserved.
//

import UIKit

enum BonusType: Int {
    case card
    case location
}



class HCBonusListViewController: UIViewController {

    //Test
    var m_aryData = [String]()
    var m_ibonusType: BonusType = .card
    var m_aryParameter = [(String, String)]()
    var m_data: Data?
    var m_bonusList: ResponseList?
    
    
    
    @IBOutlet weak var m_tvBonusList: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        setParameters()
        HttpClient().requestWithURL(urlString: k_strURL, parameters: m_aryParameter) { (data) in
            self.m_data = data
            print(data)
            self.decode()
            DispatchQueue.main.async {
                self.m_tvBonusList?.reloadData()
            }
        }
        
        m_aryData.append("First")
        m_aryData.append("Second")
        m_aryData.append("Third")
        
        
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
    
    private func setParameters() {
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
        m_aryParameter.append(("lat", "25.074578"))
        m_aryParameter.append(("lon", "121.574992"))

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
        return cell
    }
    
    
}
