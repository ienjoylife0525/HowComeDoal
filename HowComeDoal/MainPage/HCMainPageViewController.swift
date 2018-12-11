//
//  HCMainPageViewController.swift
//  HowComeDoal
//
//  Created by Patato on 2018/12/11.
//  Copyright © 2018 Patato. All rights reserved.
//

import UIKit

class HCMainPageViewController: UIViewController {
    
    
    
    @IBAction func cardBonus(_ sender: UIButton) {
        print("card Click")
        let listPage = HCBonusListViewController()
        self.navigationController?.pushViewController(listPage, animated: true)
    }
    
    @IBAction func nearBonus(_ sender: UIButton) {
        print("near Click")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


    
}
