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
    
    
    //Makes request using UPCITEMDB API to retreive relevant item data from SKU
    func makeUPCRequest(_ UPC: String) -> NSMutableDictionary {
        let url = baseURL + UPC
        let request = URLRequest(url: URL(string: url)!)
        let session = URLSession.shared
        var res: NSMutableDictionary?
        let semaphore = DispatchSemaphore(value: 0)
        session.dataTask(with: request) {(data, response, error) -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
                semaphore.signal()
            }
            
            do {
                res = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSMutableDictionary
                res!["success"] = true
                semaphore.signal()
            } catch {
                print(error.localizedDescription)
                semaphore.signal()
            }
        }.resume()
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        if (res == nil) {
            res!["success"] = false
        }
        return res!
        
    }
    
    
}
