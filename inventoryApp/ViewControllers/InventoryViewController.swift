//
//  InventoryViewController.swift
//  inventoryApp
//
//  Created by Kaya Click on 5/20/20.
//  Copyright © 2020 Kaya Click. All rights reserved.
//

import Foundation
import UIKit
import Toast
class InventoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var itemIndex: NSMutableArray!
    @IBOutlet weak var barBackButton: UIBarButtonItem!
    @IBOutlet weak var barAddItemButton: UIBarButtonItem!
    @IBOutlet weak var testUPCTextField: UILabel!

    var newlyScannedItem: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    
    func loadData() {
        itemIndex = DBHelper().getDocList()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemIndex.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = DBHelper().getDoc(itemIndex![indexPath.row] as! String)
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell")
        
        (cell?.contentView.viewWithTag(1) as! UILabel).text = item.name
        (cell?.contentView.viewWithTag(2) as! UILabel).text = item.sku
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Inventory", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ItemMaintenance") as! ItemMaintenanceViewController
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.currentItem = DBHelper().getDoc(itemIndex[indexPath.row] as! String)
        self.present(viewController, animated: true, completion: nil)
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

//    @IBAction func testQuery(_ sender: Any) {
//
//        let upc = "885909950805"
//        let response = APINetworkRequestController().makeUPCRequest(upc) { (success, json) in
//
//            if(success) {
//                print(json)
//            } else {
//                print("error!")
//            }
//
//        }
//    }
