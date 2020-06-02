//
//  APINetworkRequestController.swift
//  inventoryApp
//
//  Created by Kaya Clickon 6/1/20.
//  Copyright © 2020 Kaya Click. All rights reserved.
//

import Foundation

class APINetworkRequestController {
    var baseURL = "https://api.upcitemdb.com/prod/trial/lookup?upc="
    
    
    //Makes request using UPCITEMDB API to retreive
    func makeUPCRequest(_ UPC: String, comp: @escaping (Bool, NSDictionary) -> ()) {
        let url = baseURL + UPC
        let request = URLRequest(url: URL(string: url)!)
        let session = URLSession.shared
        var res: NSDictionary?
        
        session.dataTask(with: request) {(data, response, error) -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
                return
            }
            
            do {
                res = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                comp(true, res!)
            } catch {
                print(error.localizedDescription)
                comp(false, res!)
            }
        }.resume()
        
        
    }
    
    
}
