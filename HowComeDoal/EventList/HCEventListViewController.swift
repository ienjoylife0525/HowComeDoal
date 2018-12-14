//
//  HCEventListViewController.swift
//  HowComeDoal
//
//  Created by Patato on 2018/12/13.
//  Copyright © 2018 Patato. All rights reserved.
//

import UIKit

class HCEventListViewController: UIViewController {
    
    var m_Branch: Branch?
    var m_imgIcon: UIImage?
    
    @IBOutlet var m_tvEventList: UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        m_tvEventList?.register(UINib(nibName: "HCEventListHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "header")
        m_tvEventList?.register(UINib(nibName: "HCEventListTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        m_tvEventList?.delegate = self
        m_tvEventList?.dataSource = self
        
    }

    
}

extension HCEventListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = m_Branch?.event.count else {
            return 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = m_tvEventList?.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HCEventListTableViewCell
        cell.m_lbEventTitle?.text = m_Branch?.event[indexPath.item].title
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(k_iCellHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailPage = HCDetailViewController()
        detailPage.m_branch = m_Branch
        detailPage.m_event = m_Branch?.event[indexPath.item]
        detailPage.m_iIntdex = indexPath.item
        detailPage.m_imgIcon = m_imgIcon
        self.navigationController?.pushViewController(detailPage, animated: true)
    }
    
    
    
    // Header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(k_iCellHeight)
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = m_tvEventList?.dequeueReusableCell(withIdentifier: "header") as! HCEventListHeaderTableViewCell
        header.m_lbTitle?.text = m_Branch?.name
        header.m_imgIcon!.image = m_imgIcon
        
        return header
    }
    
    
}
