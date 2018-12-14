//
//  HCDetailViewController.swift
//  HowComeDoal
//
//  Created by Patato on 2018/12/13.
//  Copyright © 2018 Patato. All rights reserved.
//

import UIKit

class HCDetailViewController: UIViewController, UIScrollViewDelegate {
    
    var m_branch: Branch?
    var m_iIntdex: Int?
    var m_event: Event?
    var m_imgIcon: UIImage?
    
    @IBOutlet weak var m_svScroll: UIScrollView?
    @IBOutlet weak var m_lbBranchTitle: UILabel?
    @IBOutlet weak var m_ivBranchIcon: UIImageView?
    @IBOutlet weak var m_lbEventTitle: UILabel?
    @IBOutlet weak var m_lbEventDate: UILabel?
    @IBOutlet weak var m_lbDetail: UILabel?
    @IBOutlet weak var m_lbNote: UILabel?
    
    @IBAction func toRight(_ sender: UIButton) {
        
    }
    
    @IBAction func toLeft(_ sender: UIButton) {
        
    }
    
    @IBAction func toCupon(_ sender: UIButton) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSet()
        
    }
    
    private func viewSet() {
        m_lbBranchTitle?.text = m_branch?.name
        m_lbEventTitle?.text = m_event?.title
        m_lbDetail?.text = m_event?.detail
        m_lbNote?.text = m_event?.note
        m_lbEventDate?.text = dateSet()
        m_ivBranchIcon?.image = m_imgIcon
        m_svScroll?.showsVerticalScrollIndicator = true
        m_svScroll?.isScrollEnabled = true
        m_svScroll?.delegate = self
    
    }
    
    private func dateSet() -> String {
        let startDate = m_event?.startDate.components(separatedBy: " ")
        let endDate = m_event?.endDate.components(separatedBy: " ")
        
        return startDate![0] + " ~ " + endDate![0]
    }
    

}


