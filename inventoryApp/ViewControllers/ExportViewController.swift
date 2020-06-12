//
//  ExportViewController.swift
//  inventoryApp
//
//  Created by Kaya Click on 6/12/20.
//  Copyright © 2020 Kaya Click. All rights reserved.
//

import Foundation
import UIKit

class ExportViewController: UIViewController {
    @IBOutlet weak var barBackButton: UIBarButtonItem!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var docCountLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor       = staticVars().accentColour
        backgroundView.backgroundColor  = staticVars().backgroundColour
        loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    func loadData() {
        let indexCount = DBHelper().getDocList().count
        docCountLbl.text = "Document Count: \(indexCount)"
        
    }
    
    
    //Goodbye
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
