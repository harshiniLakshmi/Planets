//
//  NetworkManager.swift
//  PlanetsApp
//
//  Created by Harshini Lakshmi on 09/01/19.
//  Copyright © 2019 Harshini Lakshmi. All rights reserved.
//

import UIKit

protocol APIResponseDelegate {
    func apiresponseReceived(jsonData: [String: Any])
}

class NetworkManager: NSObject {
    
    var responseDelegate: APIResponseDelegate?
    
    func makeRequest() {
        let request = URLSession.shared.dataTask(with: URL(string: API.requestURL)!) { (data, response, error) in
            
            guard error == nil else {
                print("Encountered error")
                return
            }
            
            guard let contentData = data else {
                print("Invalid data")
                return
            }
            
            guard let json = (try? JSONSerialization.jsonObject(with: contentData, options: .mutableContainers)) as? [String: Any] else {
                print("Data doesn't contain valid json")
                return
            }

            self.responseDelegate?.apiresponseReceived(jsonData: json)
        }
        request.resume()
    }
}
