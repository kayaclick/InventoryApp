//
//  InventoryViewController.swift
//  inventoryApp
//
//  Created by Kaya Click on 5/20/20.
//  Copyright © 2020 Kaya Click. All rights reserved.
//

import Foundation
import UIKit

class InventoryViewController: UIViewController {
    
    @IBOutlet weak var barBackButton: UIBarButtonItem!
    @IBOutlet weak var barAddItemButton: UIBarButtonItem!
    
    var newlyScannedItem: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    func loadData() {
        
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

