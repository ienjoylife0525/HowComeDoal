//
//  HCEventListHeaderTableViewCell.swift
//  HowComeDoal
//
//  Created by Patato on 2018/12/13.
//  Copyright © 2018 Patato. All rights reserved.
//

import UIKit

class HCEventListHeaderTableViewCell: UITableViewCell {
    
    var m_toMap: ((_ button: UIButton) -> Void)?
    
    @IBOutlet weak var m_imgIcon: UIImageView?
    @IBOutlet weak var m_lbTitle: UILabel?
    @IBOutlet weak var m_lbDistance: UILabel?
    @IBAction func toMap(_ sender: UIButton) {
        if m_toMap != nil {
            m_toMap!(sender)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.rgb(k_cIsabelline)
        m_lbTitle?.textColor = UIColor.rgb(k_cYankeesBlue)
        m_imgIcon?.clipsToBounds = true
        m_imgIcon?.layer.cornerRadius = k_cgfCorner
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
