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
    
    @IBOutlet weak var barButtonBack: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    

    
    func loadData() {
        
        
    }
    

    
    //Goodbye
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

