//
//  InventoryViewController.swift
//  inventoryApp
//
//  Created by Kaya Click on 5/20/20.
//  Copyright © 2020 Kaya Click. All rights reserved.
//

import Foundation
import UIKit
import Toast
class InventoryViewController: UIViewController {
    
    var item: Item!
    @IBOutlet weak var barBackButton: UIBarButtonItem!
    @IBOutlet weak var barAddItemButton: UIBarButtonItem!
    @IBOutlet weak var testUPCTextField: UILabel!
    
    @IBOutlet weak var testBtn1: UIButton!
    @IBOutlet weak var testBtn2: UIButton!
    


    var newlyScannedItem: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    func loadData() {
        //testUPCTextField.text = newlyScannedItem
    }
    
    @IBAction func testBtn1Press(_ sender: Any) {
        //self.view.makeToast("Test")
//        var doc = DBHelper().getDoc("test1")
//        doc.qty = doc.qty + 1
//        DBHelper().saveDoc("test1", doc)
        
    }
    @IBAction func testBtn2Press(_ sender: Any) {
        
        //print(UserDefaults.standard.dictionary(forKey: "1"))
        var doc = DBHelper().getDoc("test1")
        //doc.qty = 1
        print(doc)
    }
    
    
    
    @IBAction func testQuery(_ sender: Any) {
        
        let upc = "885909950805"
        let response = APINetworkRequestController().makeUPCRequest(upc) { (success, json) in
            
            if(success) {
                print(json)
            } else {
                print("error!")
            }
            
        }
    }
    
    //MARK: Add Item
    @IBAction func barAddItemPressed(_ sender: Any) {
        //Present new item view
        let storyboard: UIStoryboard = UIStoryboard(name: "Inventory", bundle: nil) //remember: sb is just sb file
        let viewController = storyboard.instantiateViewController(withIdentifier: "ItemMaintenance") as! ItemMaintenanceViewController //id is for VC; as! for VC Class
        viewController.modalPresentationStyle = .overCurrentContext
        self.present(viewController, animated: true, completion: nil)
    }
    
    //MARK: Goodbye
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

