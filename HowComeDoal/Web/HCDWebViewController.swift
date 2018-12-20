//
//  HCDWebViewController.swift
//  HowComeDoal
//
//  Created by Patato on 2018/12/17.
//  Copyright © 2018 Patato. All rights reserved.
//

import UIKit
import WebKit

class HCDWebViewController: HKBaseViewController {

    var m_imgIcon: UIImage?
    var m_strTitle: String?
    var m_strWebURL: String?
    
    @IBOutlet weak var m_ivIcon: UIImageView?
    @IBOutlet weak var m_lbTitle: UILabel?
    @IBOutlet weak var m_wvWeb: WKWebView?
    @IBOutlet weak var m_vLoadingView: UIView?
    @IBOutlet weak var m_avLoading: UIActivityIndicatorView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        m_wvWeb?.navigationDelegate = self
        let url = URL(string: m_strWebURL!)
        let request = URLRequest(url: url!)
        m_wvWeb?.load(request)
        m_ivIcon?.image = m_imgIcon
        m_ivIcon?.layer.cornerRadius = k_cgfCorner
        m_ivIcon?.clipsToBounds = true
        m_lbTitle?.text = m_strTitle
        

    }
    
    
}

extension HCDWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        m_avLoading?.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        m_vLoadingView?.isHidden = true
        m_avLoading?.stopAnimating()
        m_avLoading?.isHidden = true
    }
}
