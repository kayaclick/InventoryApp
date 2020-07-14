//
//  Item.swift
//  inventoryApp
//
//  Created by Conner Dougherty on 6/7/20.
//  Copyright © 2020 Kaya Click. All rights reserved.
//

import Foundation

struct Item {
    var sku = ""
    var qty = 0
    var name = ""
    var imageURL = ""
    var brand = ""
    var asin = ""
    var elid = ""
    var par = ""
    
    var dictionary: [String: Any] {
        return [
            "sku":      sku,
            "qty":      qty,
            "name":     name,
            "imageURL": imageURL,
            "brand":    brand,
            "asin":     asin,
            "elid":     elid,
            "par":      par
            //catagory field
                ]
    }
    
    var asDict: NSDictionary {
        return dictionary as NSDictionary
    }
}

extension Item: Codable {
    init(dictionary: [String: Any]) throws {
        self = try JSONDecoder().decode(Item.self, from: JSONSerialization.data(withJSONObject: dictionary))
    }
    private enum CodingKeys: String, CodingKey {
                case sku
                case qty
                case name
                case imageURL
                case brand
                case asin
                case elid
                case par
    }
}
