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
