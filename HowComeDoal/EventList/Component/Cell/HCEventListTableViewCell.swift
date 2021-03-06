//
//  HCEventListTableViewCell.swift
//  HowComeDoal
//
//  Created by Patato on 2018/12/13.
//  Copyright © 2018 Patato. All rights reserved.
//

import UIKit

class HCEventListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var m_lbEventTitle: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.rgb(k_cIsabelline)
        m_lbEventTitle?.textColor = UIColor.rgb(k_cYankeesBlue)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
