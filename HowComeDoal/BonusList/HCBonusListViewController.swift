//
//  HCBonusListViewController.swift
//  HowComeDoal
//
//  Created by Patato on 2018/12/11.
//  Copyright © 2018 Patato. All rights reserved.
//

import UIKit
import CoreLocation

enum BonusType: Int {
    case card
    case location
}



class HCBonusListViewController: HKBaseViewController {

    var m_ibonusType: BonusType = .card
    var m_aryParameter = [(String, String)]()
    var m_bonusList: ResponseList?
    var m_strLongitude: String?
    var m_strLatitude: String?
    var m_branchs = [Branch]()
    var m_iLoadFrom: Int = 0
    var m_iLoadEnd: Int = 29
    var m_iLoadRange: Int = 30
    var m_bSendRequest: Bool = false
    var m_iBranchTotal: Int?
    var m_bLoadedAllData: Bool = false
    var m_iAdIndex: Int = 0
    let m_iTotalIndex: Int = k_aryAd.count * 5
    
    let m_picQueue = DispatchQueue(label: "com.HCD.loadpicqueue", attributes: .concurrent)
    let m_adQueue = DispatchQueue(label: "com.HCD.loadadqueue", attributes: .concurrent)
    let m_timeQueue = DispatchQueue(label: "com.HCD.timerqueue")
    
    @IBOutlet weak var m_tvBonusList: UITableView?
    @IBOutlet weak var m_vLoadingView: UIView?
    @IBOutlet weak var m_avLoading: UIActivityIndicatorView?
    @IBOutlet weak var m_cvAdvertise: UICollectionView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        m_avLoading?.startAnimating()
        
        // for TableView
        let nib = UINib(nibName: "HCBonusListTableViewCell", bundle: nil)
        m_tvBonusList?.register(nib, forCellReuseIdentifier: "BonusListCell")
        let loadNib = UINib(nibName: "HCDBonusListFooterTableViewCell", bundle: nil)
        m_tvBonusList?.register(loadNib, forCellReuseIdentifier: "LoadingCell")
        m_tvBonusList?.dataSource = self
        m_tvBonusList?.delegate = self
        
        // set CollectionView
        let adNib = UINib(nibName: "HCAdCollectionViewCell", bundle: nil)
        m_cvAdvertise?.register(adNib, forCellWithReuseIdentifier: "AdCell")
        m_cvAdvertise?.delegate = self
        m_cvAdvertise?.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (m_cvAdvertise?.frame.width)!, height: (m_cvAdvertise?.frame.height)!)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        m_cvAdvertise?.setCollectionViewLayout(layout, animated: true)
        m_cvAdvertise?.isPagingEnabled = true
    
    
        HKLocationManager.shared.getLocation { (location) in
            self.m_strLatitude = String(location.latitude)
            self.m_strLongitude = String(location.longitude)
            self.getResponse()
        }
        
        // Timer
        Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(changeBanner), userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let defaultIndex: IndexPath = IndexPath(row: m_iTotalIndex / 2, section: 0)
        m_cvAdvertise?.scrollToItem(at: defaultIndex, at: .centeredHorizontally, animated: false)
    }
    
    @objc func changeBanner() {
        m_iAdIndex += 1
        let indexPath: IndexPath
        if m_iAdIndex == m_iTotalIndex - 1{
            indexPath = IndexPath(item: k_aryAd.count * 3 - 1, section: 0)
        } else {
            indexPath = IndexPath(item: m_iAdIndex, section: 0)
        }
        m_cvAdvertise?.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    
    private func decode(data: Data) {
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(ResponseList.self, from: data)
            m_bonusList = response
            m_iBranchTotal = m_bonusList?.totalBranches

        } catch {
            print("error")
        }
    }
    
    private func getResponse() {
        let type: String
        switch m_ibonusType {
        case .card:
            type = k_iDataGroupCard
        case .location:
            type = k_iDataGroupLocation
        }
        m_bSendRequest = true
        HttpClient().getBonusList(bonusType: type, lat: m_strLatitude!, lon: m_strLongitude!, index: m_iLoadFrom, range: m_iLoadRange, completion: { (data) in
            self.decode(data: data)
            print("Data back!! \(data)")
            
            if self.m_iLoadEnd > self.m_branchs.count {
                self.m_branchs += (self.m_bonusList?.branch)!
                print("Branchs count: \(self.m_branchs.count)")
            }
            if self.m_iLoadEnd > self.m_iBranchTotal! - 1{
                self.m_iLoadEnd = self.m_iBranchTotal! - 1
                self.m_bLoadedAllData = true
            }
            //Update UI
            self.m_tvBonusList?.reloadData()
            self.m_vLoadingView?.isHidden = true
            self.m_avLoading?.stopAnimating()
            self.m_avLoading?.isHidden = true
            
            self.m_bSendRequest = false
            
        }) { (error) in
            print(error)
        }
    }
}

extension HCBonusListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if m_branchs.count == 0 {
            return 0
        }
        //For loading view
        let count = m_branchs.count
        if m_iLoadEnd != m_iBranchTotal! - 1 {
            return count + 1
        } else {
            return count
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Loading Footer Cell
        if m_bLoadedAllData == false {
            if indexPath.item == m_branchs.count {
                let cell = m_tvBonusList?.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as! HCDBonusListFooterTableViewCell
                cell.m_avLoading?.startAnimating()
                return cell
            }
        }
        
        //Normal Cell
        let cell = m_tvBonusList?.dequeueReusableCell(withIdentifier: "BonusListCell", for: indexPath) as! HCBonusListTableViewCell
        cell.m_lbTitle?.text = m_branchs[indexPath.item].name
        cell.m_lbDistance?.text = m_branchs[indexPath.item].distance + " km"
        cell.tag = indexPath.item
        if m_branchs[indexPath.item].logo != "" {
            //Mutiple Thread
            m_picQueue.async {
                let url = URL(string: self.m_branchs[indexPath.item].logo)
                let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    if cell.tag == indexPath.item {
                        cell.m_ivmgIcon?.image = UIImage(data: data!)
                        cell.m_fToMap = { (button: UIButton) -> Void in
                            let mapPage = HCMapViewController()
                            mapPage.m_branch = self.m_branchs[indexPath.item]
                            mapPage.m_imgIcon = UIImage(data: data!)
                            self.navigationController?.pushViewController(mapPage, animated: true)
                        }
                    }
                }
            }
        } else {
            cell.m_ivmgIcon?.image = UIImage(named: "defaultIcon")
        }
        
//        print("\(indexPath.row) + \(m_branchs[indexPath.row].name)")
        if m_iLoadEnd < m_iBranchTotal! - 1 {
            if m_bSendRequest == false {
                if indexPath.item + 1 == m_branchs.count - m_iLoadRange / 2 {
                    m_iLoadFrom += m_iLoadRange
                    m_iLoadEnd += m_iLoadRange
                    if m_iLoadEnd > m_iBranchTotal! - 1{
                        let range = m_iBranchTotal! - m_iLoadFrom
                        m_iLoadRange = range
                        getResponse()
                    } else {
                        getResponse()
                    }
                }
            }
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(k_iCellHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventPage = HCEventListViewController()
        if m_branchs[indexPath.item].logo != "" {
            let url = URL(string: m_branchs[indexPath.item].logo)
            let data = try? Data(contentsOf: url!)
            eventPage.m_imgIcon = UIImage(data: data!)!
        } else {
            eventPage.m_imgIcon = UIImage(named: "defaultIcon")
        }
        eventPage.m_Branch = m_branchs[indexPath.item]
        self.navigationController?.pushViewController(eventPage, animated: true)
    }
    
}

extension HCBonusListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return m_iTotalIndex
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdCell", for: indexPath) as! HCAdCollectionViewCell
        let adIndex = indexPath.item % k_aryAd.count
        cell.m_ivAd?.image = UIImage(named: "defaultIcon")
        m_adQueue.async {
            let url = URL(string: k_aryAd[adIndex])
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.sync {
                cell.m_ivAd?.image = UIImage(data: data!)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(indexPath.item)
        m_iAdIndex = indexPath.item
        if indexPath.item == m_iTotalIndex - 1{
            let midIndex = IndexPath(row: k_aryAd.count * 3 - 2, section: 0)
            m_cvAdvertise?.scrollToItem(at: midIndex, at: .centeredHorizontally, animated: false)
        } else if indexPath.item == 0 {
            let midIndex = IndexPath(row: k_aryAd.count * 2 + 1, section: 0)
            m_cvAdvertise?.scrollToItem(at: midIndex, at: .centeredHorizontally, animated: false)
        }
    }
    
    
    
    
}
