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
        loadData()
    }
    

    
    func loadData() {
        if(currentItem == nil) { //No selected item passed in
            //currentItem = Item()
            currentItem = DBHelper().getDoc("test1") //load test doc
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
    
    
    
    
    
    //MARK: TODO
    @IBAction func saveButtonPressed(_ sender: Any) {
        if (nameField.text == nil || nameField.text == "") {
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

