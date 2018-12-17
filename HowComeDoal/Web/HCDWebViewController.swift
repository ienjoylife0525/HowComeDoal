//
//  HCDWebViewController.swift
//  HowComeDoal
//
//  Created by Patato on 2018/12/17.
//  Copyright © 2018 Patato. All rights reserved.
//

import UIKit
import WebKit

class HCDWebViewController: UIViewController {

    var m_imgIcon: UIImage?
    var m_strTitle: String?
    var m_strWebURL: String?
    
    @IBOutlet weak var m_ivIcon: UIImageView?
    @IBOutlet weak var m_lbTitle: UILabel?
    @IBOutlet weak var m_wvWeb: WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: m_strWebURL!)
        let request = URLRequest(url: url!)
        m_wvWeb?.load(request)
        m_ivIcon?.image = m_imgIcon
        m_lbTitle?.text = m_strTitle

    }



}
