//
//  HCBonusListTableViewCell.swift
//  HowComeDoal
//
//  Created by Patato on 2018/12/11.
//  Copyright © 2018 Patato. All rights reserved.
//

import UIKit

class HCBonusListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var m_ivmgIcon: UIImageView?
    @IBOutlet weak var m_lbTitle: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
