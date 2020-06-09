//
//  DatabaseHelperFunctions.swift
//  inventoryApp
//
//  Created by Kaya Click on 6/7/20.
//  Copyright © 2020 Kaya Click. All rights reserved.
//

import Foundation

class DBHelper {
    
    //MARK: Document functions
    
    //Gets document
    func getDoc(_ SKU: String) -> Item {
        do  {
            let doc = try Item(dictionary: UserDefaults.standard.dictionary(forKey: SKU)!)
            return doc
        } catch {
            return Item() // Some error has occured, return new Item
        }
    }
    
    
    //Converts and saves document
    func saveDoc(_ SKU: String, _ doc: Item) {
        let index = getDocList()
        if (!index.contains(SKU)) { //SKU does not exist in index
            index.add(SKU)
            saveDocList(index) //Add SKU to index and save index
        }
        UserDefaults.standard.set(doc.asDict, forKey: SKU)
    }
    
    
    //Deletes document and returns bool success
    func deleteDoc(_ SKU: String) -> Bool {
        UserDefaults.standard.removeObject(forKey: SKU)
        return !doesSKUExist(SKU) //successful deletion results in...the document not existing so invert bool
    }
    
    
     //MARK: Index functions
     //Get Index of documents; necessary as other data can be stored in userdefaults alongside doc info
     func getDocList() -> NSMutableArray {
         let index = UserDefaults.standard.array(forKey: "index")
         if(index == nil) { //Look at index and see if it exists
             let newIndex = [String]() //If not, create an empty NSARRAY and return
             UserDefaults.standard.set(newIndex, forKey: "index")
         }
         return NSMutableArray(array: UserDefaults.standard.array(forKey: "index")!)// as! NSMutableArray
     }
     
    //saves index doc
     func saveDocList(_ docList: NSMutableArray) {
         UserDefaults.standard.set(docList, forKey: "index")
     }
     
    
    
    //MARK: Helper functions
    //Verifies existence of document in database
    func doesSKUExist(_ SKU: String) -> Bool {
        let doc = UserDefaults.standard.dictionary(forKey: SKU)
        if(doc != nil) {
            return true
        } else {
            return false
        }
    }
    
    
    
}
