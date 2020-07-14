//
//  MainVC.swift
//  inventoryApp
//
//  Created by Kaya Click on 5/20/20.
//  Copyright © 2020 Kaya Click. All rights reserved.
//

import UIKit

extension UINavigationController {

    func setStatusBar(backgroundColor: UIColor) {
        let statusBarFrame: CGRect
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = staticVars().accentColour
        view.addSubview(statusBarView)
    }

}

class MainVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var versionLbl: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var mainOptMenu: UITableView!
    var pages: [String] = [ "Inventory",
                            "Scan",
                            //"Import / Export",
                            "Settings",
                            "Upgrade",
                            "Reports"
                            ]
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    func loadData() {
        backgroundView.backgroundColor  = staticVars().accentColour
        mainOptMenu.backgroundColor     = staticVars().backgroundColour
        versionLbl.text                 = staticVars().versionNum
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
        cell.backgroundColor = staticVars().backgroundColour
        cell.textLabel!.textColor = staticVars().textColour
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
        } else if (sb == "Import / Export") {
            let storyboard: UIStoryboard = UIStoryboard(name: "Export", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "Export") as! ExportViewController
            viewController.modalPresentationStyle = .overCurrentContext
            present(viewController, animated: true, completion: nil)
            
        } else if (sb == "Reports") {
            let storyboard: UIStoryboard = UIStoryboard(name: "Reports", bundle: nil)
            let viewController = storyboard.instantiateViewController(identifier: "Reports") as! ReportsViewController
            viewController.modalPresentationStyle = .overCurrentContext
            present(viewController, animated: true, completion: nil)
        }
//        let storyboard: UIStoryboard = UIStoryboard(name: "Printer", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "PrinterController") as! PrinterViewController
//
//        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//
//        present(vc, animated: true, completion: nil)
    }
    
}

