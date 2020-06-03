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
    @IBOutlet weak var testBtn: UIButton!
    var newlyScannedItem: String = ""
    
    @IBOutlet weak var testLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    func loadData() {
        if (newlyScannedItem != "") {
            testLbl.text = newlyScannedItem
        }
        
        
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
    
    //Goodbye
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

