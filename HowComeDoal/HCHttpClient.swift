//
//  HCHttpClient.swift
//  HowComeDoal
//
//  Created by Patato on 2018/12/11.
//  Copyright © 2018 Patato. All rights reserved.
//

import Foundation

class HttpClient: NSObject {
    var downloadCompletionBlock: ((_ data: Data) -> Void)?
    
    func requestWithURL(urlString: String, parameters: [(String, String)], completion: @escaping (Data) -> Void) {
        var urlComponents = URLComponents(string: urlString)!
        urlComponents.queryItems = []
        
        for (key, value) in parameters {
            urlComponents.queryItems?.append(URLQueryItem(name: key, value: value))
        }
        
        guard let queryedURL = urlComponents.url else { return }
        print(queryedURL)
        let request = URLRequest(url: queryedURL)
        fetchDataByDataTask(from: request, completion: completion)
        
    }
    
    func fetchDataByDataTask(from request: URLRequest, completion: @escaping (Data) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error as Any)
            } else {
                guard let data = data else { return }
                print(data)
                completion(data)
            }
        }
        task.resume()
    }
}
