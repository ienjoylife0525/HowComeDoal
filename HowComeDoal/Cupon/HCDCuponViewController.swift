//
//  HCDCuponViewController.swift
//  HowComeDoal
//
//  Created by Patato on 2018/12/17.
//  Copyright © 2018 Patato. All rights reserved.
//

import UIKit

class HCDCuponViewController: HKBaseViewController {
    
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
        
        
    }
    
}
