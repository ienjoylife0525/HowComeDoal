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
    @IBOutlet weak var m_lbDistance: UILabel?
    @IBOutlet weak var m_lbEventTitle: UILabel?
    @IBOutlet weak var m_lbEventDate: UILabel?
    @IBOutlet weak var m_lbDetail: UILabel?
    @IBOutlet weak var m_lbNote: UILabel?
    @IBOutlet weak var m_btnRight: UIButton?
    @IBOutlet weak var m_btnLeft: UIButton?
    @IBOutlet weak var m_btnCupon: UIButton?
    @IBOutlet weak var m_btnWeb: UIButton?
    
    @IBAction func toRight(_ sender: UIButton) {
        var nextIndex = m_iIntdex! + 1
        if nextIndex == m_branch?.event.count {
            nextIndex = 0
        }
        m_event = m_branch?.event[nextIndex]
        eventChange()
        m_iIntdex = nextIndex
    }
    
    @IBAction func toLeft(_ sender: UIButton) {
        var nextIndex = m_iIntdex! - 1
        if nextIndex < 0 {
            nextIndex = (m_branch?.event.count)! - 1
        }
        m_event = m_branch?.event[nextIndex]
        eventChange()
        m_iIntdex = nextIndex
    }
    
    @IBAction func toCupon(_ sender: UIButton) {
        let cuponPage = HCDCuponViewController()
        cuponPage.m_imgIcon = m_imgIcon
        cuponPage.m_strTitle = m_branch?.name
        cuponPage.m_strCuponURL = m_event?.eventPic[0].url
        self.navigationController?.pushViewController(cuponPage, animated: true)
    }
    
    @IBAction func toWeb(_ sender: UIButton) {
        let webPage = HCDWebViewController()
        webPage.m_imgIcon = m_imgIcon
        webPage.m_strTitle = m_event?.title
        webPage.m_strWebURL = m_event?.website
        self.navigationController?.pushViewController(webPage, animated: true)
    }
    
    @IBAction func toMap(_ sender: UIButton) {
        let mapPage = HCMapViewController()
        mapPage.m_branch = m_branch
        mapPage.m_imgIcon = m_imgIcon
        self.navigationController?.pushViewController(mapPage, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSet()
        
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
    
    private func eventChange() {
        m_lbEventTitle?.text = m_event?.title
        m_lbDetail?.text = m_event?.detail
        m_lbNote?.text = m_event?.note
        m_lbEventDate?.text = dateSet()
    }
    
    private func viewSet() {
        self.view.backgroundColor = UIColor.rgb(k_cIsabelline)
        m_lbBranchTitle?.text = m_branch?.name
        m_lbDistance?.text = (m_branch?.distance)! + " km"
        m_lbEventTitle?.text = m_event?.title
        m_lbDetail?.text = m_event?.detail
        m_lbNote?.text = m_event?.note
        m_lbEventDate?.text = dateSet()
        m_ivBranchIcon?.image = m_imgIcon
        if m_branch?.event.count == 1 {
            m_btnLeft?.isHidden = true
            m_btnRight?.isHidden = true
        }
        if m_event?.eventPic[0].url == "" {
            m_btnCupon?.isEnabled = false
        }
        if m_event?.website == "" {
            m_btnWeb?.isEnabled = false
        }
        m_svScroll?.showsVerticalScrollIndicator = true
        m_svScroll?.isScrollEnabled = true
        m_svScroll?.delegate = self
    
    }
    
    private func dateSet() -> String {
        let startDate = m_event?.startDate.components(separatedBy: " ")
        let endDate = m_event?.endDate.components(separatedBy: " ")
        if startDate![0] == "0000-00-00" {
            return "截止至 " + endDate![0]
        }
        
        return startDate![0] + " ~ " + endDate![0]
    }
    

}




