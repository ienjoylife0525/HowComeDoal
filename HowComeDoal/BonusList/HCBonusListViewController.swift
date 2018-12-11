//
//  HCBonusListViewController.swift
//  HowComeDoal
//
//  Created by Patato on 2018/12/11.
//  Copyright © 2018 Patato. All rights reserved.
//

import UIKit

class HCBonusListViewController: UIViewController {

    //Test
    var m_aryData = [String]()
    
    @IBOutlet weak var m_tvBonusList: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        m_aryData.append("First")
        m_aryData.append("Second")
        m_aryData.append("Third")
        
        let nib = UINib(nibName: "HCBonusListTableViewCell", bundle: nil)
        
        m_tvBonusList?.register(nib, forCellReuseIdentifier: "BonusListCell")
        m_tvBonusList?.dataSource = self
        m_tvBonusList?.dataSource = self
    }


}

extension HCBonusListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return m_aryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = m_tvBonusList?.dequeueReusableCell(withIdentifier: "BonusListCell", for: indexPath) as! HCBonusListTableViewCell
        
        cell.m_lbTitle?.text = m_aryData[indexPath.item]
        return cell
    }
    
    
}
