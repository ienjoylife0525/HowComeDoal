//
//  HCEventListHeaderTableViewCell.swift
//  HowComeDoal
//
//  Created by Patato on 2018/12/13.
//  Copyright © 2018 Patato. All rights reserved.
//

import UIKit

class HCEventListHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var m_imgIcon: UIImageView?
    @IBOutlet weak var m_lbTitle: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        m_lbTitle?.textColor = UIColor.rgb(k_cYankeesBlue)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
