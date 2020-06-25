//
//  SettingsViewController.swift
//  inventoryApp
//
//  Created by Kaya Click on 5/21/20.
//  Copyright © 2020 Kaya Click. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var barBackButton: UIBarButtonItem!
    @IBOutlet weak var numOfRetriesField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    
    func loadData() {
        numOfRetriesField.text = String(UserDefaults.standard.integer(forKey: "numberOfScanRetries"))
        
        
    }
    
    
    
    //Reconfigures settings in runtime
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        save()
    }

    func save() {
        UserDefaults.standard.set(Int(numOfRetriesField.text!), forKey: "numberOfScanRetries")
    }
    
    //Goodbye
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

