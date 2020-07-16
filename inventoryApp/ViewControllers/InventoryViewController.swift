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
class InventoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var itemIndex: NSMutableArray!
    var filteredItemIndex: NSMutableArray!
    @IBOutlet weak var barObject: UINavigationBar!
    @IBOutlet weak var barBackButton: UIBarButtonItem!
    @IBOutlet weak var barAddItemButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var itemListSearchBar: UISearchBar!
    
    var newlyScannedItem: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        itemIndex = DBHelper().getDocList()
        filteredItemIndex = itemIndex
        tableView.backgroundColor = staticVars().backgroundColour
        self.view.backgroundColor = staticVars().accentColour
    }
    
    
    
    //MARK: TableView logic
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItemIndex.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = DBHelper().getDoc(filteredItemIndex![indexPath.row] as! String)
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell")
        cell!.backgroundColor = staticVars().backgroundColour
        (cell?.contentView.viewWithTag(1) as! UILabel).text = item.name
        (cell?.contentView.viewWithTag(1) as! UILabel).textColor = staticVars().textColour
        //(cell?.contentView.viewWithTag(2) as! UILabel).text = item.sku
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Inventory", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ItemMaintenance") as! ItemMaintenanceViewController
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.currentItem = DBHelper().getDoc(filteredItemIndex[indexPath.row] as! String)
        self.present(viewController, animated: true, completion: nil)
    }
    
    
    
    //MARK: Search bar logic
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        //TODO add simple / complex filter setting
        if (true) {
            fancyFilter(itemListSearchBar.text!)
        } else {
            simpleFilter(itemListSearchBar.text!)
        }
        
    }
    
    
    
    
    //MARK: Filtering Logic
    //This filters just by SKU, toggle option if verbose filtering gets super slow with lots of data
    func simpleFilter(_ filterStr: String) {
        itemIndex = DBHelper().getDocList()
        var tempArry: [String] = []
        for item in itemIndex {
            if ((item as! String).contains(filterStr)) {
                tempArry.append(item as! String)
            }
        }
        filteredItemIndex = NSMutableArray(array: tempArry)
        tableView.reloadData()
    }
    
    //Filter checks against SKU, name of item, and a few other cases instead of just SKU
    func fancyFilter(_ filterStr: String) {
        itemIndex = DBHelper().getDocList()
        let filterStrLower = filterStr.lowercased()
        var tempArry: [String] = []
        for item in itemIndex {
            let tempItem = DBHelper().getDoc(item as! String)
            if (item as! String).contains(filterStrLower) || tempItem.name.lowercased().contains(filterStrLower) || tempItem.brand.lowercased().contains(filterStrLower){
                tempArry.append(item as! String)
            }
        }
        filteredItemIndex = NSMutableArray(array: tempArry)
        tableView.reloadData()
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
