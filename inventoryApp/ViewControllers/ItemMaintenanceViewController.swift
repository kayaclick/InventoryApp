//
//  ItemMaintenanceViewController.swift
//  inventoryApp
//
//  Created by Kaya Click on 6/2/20.
//  Copyright © 2020 Kaya Click. All rights reserved.
//

import Foundation
import UIKit

class ItemMaintenanceViewController: UIViewController {
    var currentItem: Item!
    var isImportingNewItem: Bool = false
    
    @IBOutlet weak var barButtonBack: UIBarButtonItem!
    @IBOutlet weak var barButtonSave: UIBarButtonItem!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var skuField: UITextField!
    @IBOutlet weak var qtyField: UITextField!
    @IBOutlet weak var brandField: UITextField!
    @IBOutlet weak var elidField: UITextField!
    @IBOutlet weak var asinField: UITextField!
    @IBOutlet weak var urlField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (isImportingNewItem) {
            self.view.makeToast("New Item! Let's add it now.", duration: 1.5, position: .center)
            //importItemData()
        }
        
        loadData()
        
        
    }
    

    
    func loadData() {
        if(currentItem == nil) { //No selected item passed in
            currentItem = Item()
            //currentItem = DBHelper().getDoc("test1") //load test doc
        }
        
        //load fields
        nameField.text      = currentItem.name
        skuField.text       = currentItem.sku
        qtyField.text       = String(currentItem.qty)
        brandField.text     = currentItem.brand
        elidField.text      = currentItem.elid
        asinField.text      = currentItem.asin
        urlField.text       = currentItem.imageURL //TODO: Go away
    }
    
    func importItemData() {
        //do network query and populate data
        let response = APINetworkRequestController().makeUPCRequest(currentItem.sku) { (success, json) in
            
            if(success) {
                print(json)
            } else {
                print("error!")
            }
            
        }
        
    }
    
    
    
    //MARK: TODO
    @IBAction func saveButtonPressed(_ sender: Any) {
        if (skuField.text == nil || skuField.text == "") {
            print("throw err!")
        } else {
            
            currentItem.name        = nameField.text!
            currentItem.sku         = skuField.text!
            currentItem.qty         = Int(qtyField.text!)!
            currentItem.brand       = brandField.text!
            currentItem.elid        = elidField.text!
            currentItem.asin        = asinField.text!
            currentItem.imageURL    = urlField.text!
            
            
            DBHelper().saveDoc(skuField.text!, currentItem)
        }
    }
    
    //Goodbye
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

