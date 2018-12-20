//
//  HKBaseViewController.swift
//  HowComeDoal
//
//  Created by Patato on 2018/12/20.
//  Copyright © 2018 Patato. All rights reserved.
//

import UIKit

class HKBaseViewController: UIViewController {
    
    override func viewDidLoad() {
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
