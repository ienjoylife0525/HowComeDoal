//
//  HCBonusListTableViewCell.swift
//  HowComeDoal
//
//  Created by Patato on 2018/12/11.
//  Copyright © 2018 Patato. All rights reserved.
//

import UIKit

class HCBonusListTableViewCell: UITableViewCell {
    
    var m_fToMap: ((_ button: UIButton) -> Void)?
    
    @IBOutlet weak var m_ivmgIcon: UIImageView?
    @IBOutlet weak var m_lbTitle: UILabel?
    @IBOutlet weak var m_lbDistance: UILabel?
    
    @IBAction func toMap(_ sender:UIButton) {
        if m_fToMap != nil {
            m_fToMap!(sender)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        m_lbTitle?.textColor = UIColor.rgb(k_cYankeesBlue)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        m_ivmgIcon?.image = UIImage(named: "defaultIcon")
    }
}
