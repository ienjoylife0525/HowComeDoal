//
//  HCHttpClient.swift
//  HowComeDoal
//
//  Created by Patato on 2018/12/11.
//  Copyright © 2018 Patato. All rights reserved.
//

import Foundation
import Alamofire

class HttpClient: NSObject {
    
    func requestWithURL(urlString: String, parameters: [(String, String)], completion: @escaping (Data) -> Void) {
        var urlComponents = URLComponents(string: urlString)!
        urlComponents.queryItems = []
        
        for (key, value) in parameters {
            urlComponents.queryItems?.append(URLQueryItem(name: key, value: value))
        }
        
        guard let queryedURL = urlComponents.url else { return }
        let request = URLRequest(url: queryedURL)
        fetchDataByDataTask(from: request, completion: completion)
        
    }
    
    func fetchDataByDataTask(from request: URLRequest, completion: @escaping (Data) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error as Any)
            } else {
                guard let data = data else { return }
                completion(data)
            }
        }
        task.resume()
    }
    
    func getBonusList(bonusType type: String, lat: String, lon: String, index: Int, range: Int, completion: @escaping (Data) -> Void, failure: @escaping (String) -> Void) {
        var urlComponents = URLComponents(string: k_strURL)!
        //Set parameter
        var m_aryParameter = [(String, String)]()
        m_aryParameter.append(("appId", k_iAppId))
        m_aryParameter.append(("dataGroupCode", type))
        m_aryParameter.append(("index", String(index)))
        m_aryParameter.append(("limit", String(range)))
        m_aryParameter.append(("OS", k_strDevice))
        m_aryParameter.append(("lat", lat))
        m_aryParameter.append(("lon", lon))
        urlComponents.queryItems = []
        for (key, value) in m_aryParameter {
            urlComponents.queryItems?.append(URLQueryItem(name: key, value: value))
        }
        
        guard let queryedURL = urlComponents.url else { return }
        
        Alamofire.request(queryedURL).responseJSON { (response) in
            if response.result.isSuccess {
                guard let data = response.data else {
                    failure("Data Error")
                    return
                }
                completion(data)
                
            } else {
                failure("API Error")
            }
        }
        
    }
}


