//
//  CheckoutViewController.swift
//  inventoryApp
//
//  Created by Conner Dougherty on 7/14/20.
//  Copyright © 2020 Kaya Click. All rights reserved.
//

import Foundation
import UIKit
class CheckoutViewController: UIViewController {
    
    @IBOutlet weak var barBackButton: UIBarButtonItem!
    @IBOutlet weak var submitButton:  UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        
        
    }
    
    
    @IBAction func submitPressed(_ sender: Any) {
        
        
    }
    
    //MARK: Goodbye
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}
