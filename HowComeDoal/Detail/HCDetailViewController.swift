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
    
    @IBOutlet weak var m_svScroll: UIScrollView?
    @IBOutlet weak var m_lbBranchTitle: UILabel?
    @IBOutlet weak var m_imgBranchIcon: UIImageView?
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
        m_svScroll?.showsVerticalScrollIndicator = true
        m_svScroll?.isScrollEnabled = true
        m_svScroll?.delegate = self
    }
    

}


