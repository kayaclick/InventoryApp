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
    
    @IBOutlet weak var exportCSV: UIButton!
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
    
    @IBAction func exportCSVPressed(_ sender: Any) {
        exportData()
    }
    func exportData() {
        let fileName = "Inventory.csv"
        var csvText = "SKU,qty,Name,imageURL,brand,asin,elid\n"
        let index = DBHelper().getDocList()
        
        for docid in index { //Iterate doc list and pull doc info
            let doc = DBHelper().getDoc(docid as! String)
            let tempString = "\(doc.sku),\(doc.qty),\(doc.name),\(doc.imageURL),\(doc.brand),\(doc.asin),\(doc.elid)\n"
            csvText.append(tempString)
            
        }
        
        guard let path = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(fileName) as NSURL
            else {
                return
            }
        
        do {
            try csvText.write(to: path as URL, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("Failed to write csv!") //toast here
        }
    }
    
    //Goodbye
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
