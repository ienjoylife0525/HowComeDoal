//
//  HCAdCollectionViewCell.swift
//  HowComeDoal
//
//  Created by Patato on 2018/12/21.
//  Copyright © 2018 Patato. All rights reserved.
//

import UIKit

class HCAdCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var m_ivAd: UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        m_ivAd?.layer.cornerRadius = k_cgfCorner
        m_ivAd?.clipsToBounds = true
    }

}
