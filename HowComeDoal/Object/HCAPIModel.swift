//
//  HCAPIModel.swift
//  HowComeDoal
//
//  Created by Patato on 2018/12/11.
//  Copyright © 2018 Patato. All rights reserved.
//

import Foundation

struct ResponseList: Decodable {
    let errcde: String
    let errmsg: String
    let totalBranches: Int
    let branch: [Branch]
    
}

struct Branch: Decodable {
    let distance: String
    let id: String
    let name: String
    let lat: String
    let lon: String
    let addr: String
    let logo: String
    let event: [Event]
    
}

struct Event: Decodable {
    let title: String
    let eventId: String
    let detail: String
    let phone: String
    let website: String
    let note: String
    let startDate: String
    let endDate: String
    let lastUpdateTime: String
    let eventPic: [EventPic]
    
}

struct EventPic: Decodable {
    let url: String
}



