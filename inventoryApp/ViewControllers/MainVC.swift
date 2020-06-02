//
//  MainVC.swift
//  inventoryApp
//
//  Created by Conner Dougherty on 5/20/20.
//  Copyright © 2020 Kaya Click. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var mainOptMenu: UITableView!
    var pages: [String] = [ "Inventory",
                            "Scan",
                            "Settings",
                            "Upgrade"
                            ]
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    func loadData() {
        
        
        
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)  -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel!.text = pages[(indexPath as NSIndexPath).row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Transition to screen:", pages[(indexPath as NSIndexPath).row])
        transition(pages[(indexPath as NSIndexPath).row])
    }
    
    
    func transition(_ sb: String) {
        if(sb == "Inventory") {
            let storyboard: UIStoryboard = UIStoryboard(name: "Inventory", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Inventory") as! InventoryViewController
            viewController.modalPresentationStyle = .overCurrentContext
            present(viewController, animated: true, completion: nil)
        } else if (sb == "Scan") {
            let storyboard: UIStoryboard = UIStoryboard(name: "Scan", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Scan") as! ScanViewController
            viewController.modalPresentationStyle = .overCurrentContext
            present(viewController, animated: true, completion: nil)
        } else if (sb == "Settings") {
            let storyboard: UIStoryboard = UIStoryboard(name: "Settings", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Settings") as! SettingsViewController
            viewController.modalPresentationStyle = .overCurrentContext
            present(viewController, animated: true, completion: nil)
        } else if (sb == "Upgrade") {
            
        }
//        let storyboard: UIStoryboard = UIStoryboard(name: "Printer", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "PrinterController") as! PrinterViewController
//
//        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//
//        present(vc, animated: true, completion: nil)
    }
    
}

