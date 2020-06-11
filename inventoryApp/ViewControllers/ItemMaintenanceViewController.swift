//
//  ItemMaintenanceViewController.swift
//  inventoryApp
//
//  Created by Kaya Click on 6/2/20.
//  Copyright © 2020 Kaya Click. All rights reserved.
//

import Foundation
import UIKit
import Toast

class ItemMaintenanceViewController: UIViewController, UITextFieldDelegate {
    
    var currentItem: Item!
    var isImportingNewItem: Bool = false
    
    
    @IBOutlet weak var barButtonBack:   UIBarButtonItem!
    @IBOutlet weak var barButtonSave:   UIBarButtonItem!
    @IBOutlet weak var nameField:       UITextField!
    @IBOutlet weak var skuField:        UITextField!
    @IBOutlet weak var qtyField:        UITextField!
    @IBOutlet weak var brandField:      UITextField!
    @IBOutlet weak var elidField:       UITextField!
    @IBOutlet weak var asinField:       UITextField!
    @IBOutlet weak var urlField:        UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    //MARK: TODO qty field return
    
    //Resigns keyboard on return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    //MARK: Load Data
    func loadData() {
        if(currentItem == nil) { //No selected item passed in somehow
            currentItem = Item()
        }
        
        //load fields
        nameField.text      = currentItem.name
        skuField.text       = currentItem.sku
        qtyField.text       = String(currentItem.qty)
        brandField.text     = currentItem.brand
        elidField.text      = currentItem.elid
        asinField.text      = currentItem.asin
        
        if (isImportingNewItem) { //Make network request, override defaults with retreived info
            importItemData()
            self.view.makeToast("New Item! Let's add it now.", duration: 1.5, position: .center)
        }
    }
    
    
    //MARK: TODO net req
    func importItemData() {
        //do network query and populate data
        var response = APINetworkRequestController().makeUPCRequest(currentItem.sku)
        let parsedRes = (response["items"] as! NSArray)[0] as! NSDictionary
        elidField.text = parsedRes["elid"] as! String
        brandField.text = parsedRes["brand"] as! String
        nameField.text = parsedRes["description"] as! String
        
        /*
         returns:
         description
         category
         brand
         ean
         weight
         title
         upc
         images []
         elid
         model
         */
        print(response)
        
    }
    
    
    
    //MARK: Save Data
    @IBAction func saveButtonPressed(_ sender: Any) {
        if (skuField.text == "") {
            self.view.makeToast("Cannot save! Document must have a SKU!", duration: 3, position: .center)
        } else if (nameField.text == "" || qtyField.text == "") {
            self.view.makeToast("Cannot save! Check your fields as required fields are missing!", duration: 3, position: .center)
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
    
    //MARK: Goodbye
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

