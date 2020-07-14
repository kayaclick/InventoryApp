//
//  ReportsViewController.swift
//  inventoryApp
//
//  Created by Kaya Click on 7/13/20.
//  Copyright © 2020 Kaya Click. All rights reserved.
//

import Foundation
import UIKit
class ReportsViewController: UIViewController {
    
    @IBOutlet weak var barBackButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
