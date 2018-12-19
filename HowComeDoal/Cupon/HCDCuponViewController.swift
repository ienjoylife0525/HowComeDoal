//
//  HCDCuponViewController.swift
//  HowComeDoal
//
//  Created by Patato on 2018/12/17.
//  Copyright © 2018 Patato. All rights reserved.
//

import UIKit

class HCDCuponViewController: UIViewController {
    
    var m_strTitle: String?
    var m_imgIcon: UIImage?
    var m_strCuponURL: String?
    
    @IBOutlet weak var m_ivIcon: UIImageView?
    @IBOutlet weak var m_lbTitle: UILabel?
    @IBOutlet weak var m_ivCupon: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        m_lbTitle?.text = m_strTitle
        m_ivIcon?.image = m_imgIcon
        m_ivIcon?.layer.cornerRadius = k_cgfCorner
        m_ivIcon?.clipsToBounds = true
        let url = URL(string: m_strCuponURL!)
        let data = try? Data(contentsOf: url!)
        m_ivCupon?.image = UIImage(data: data!)
        
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
