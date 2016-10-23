//
//  FilterViewController.swift
//  Yelp
//
//  Created by Kyou on 10/22/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    var isFiltered = false
    
    var isExpand = ["Distance": false, "Sort": false, "Category": false]
    var filterData = ["Distance": ["0.3", "1", "2", "3", "4", "5"],
                          "Sort": ["Best match"],
                          "Category": ["Viet", "Thai"]]
    var selectedFilter = [String: String]()
    
    @IBOutlet weak var filterTableView: UITableView!
    @IBAction func onCancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSearchButton(_ sender: UIBarButtonItem) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        filterTableView.delegate = self
        filterTableView.dataSource = self

    }

}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            if isExpand["Distance"]!{
                return filterData["Distance"]!.count
            }else{
                return 1
            }
            
        case 2:
            if isExpand["Sort"]!{
                return filterData["Sort"]!.count
            }else{
                return 1
            }
        case 3:
            if isExpand["Category"]!{
                return filterData["Category"]!.count
            }else{
                return 1
            }
        default:
            return 1
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let filterCell = tableView.dequeueReusableCell(withIdentifier: "filterCell") as! FilterCell
            
            return filterCell
        // Distance
        case 1:
            let filterCell2 = tableView.dequeueReusableCell(withIdentifier: "filterCell2") as! FilterCell2
            filterCell2.distanceLabel.text = isFiltered ? selectedFilter["Distance"] : filterData["Distance"]![indexPath.row] + " miles"
            return filterCell2
        // Sort
        case 2:
            let filterCell2 = tableView.dequeueReusableCell(withIdentifier: "filterCell2") as! FilterCell2
            filterCell2.distanceLabel.text = isFiltered ? selectedFilter["Sort"] : filterData["Sort"]?[indexPath.row]
            return filterCell2
        // Category
        case 3:
            let filterCell2 = tableView.dequeueReusableCell(withIdentifier: "filterCell2") as! FilterCell2
            filterCell2.distanceLabel.text = isFiltered ? selectedFilter["Category"] : filterData["Category"]?[indexPath.row]
            return filterCell2
        default:
            let filterCell2 = tableView.dequeueReusableCell(withIdentifier: "filterCell2") as! FilterCell2
            return filterCell2
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return ""
        case 1:
            return "Distance"
        case 2:
            return "Sort by"
        case 3:
            return "Category"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        
        
        switch indexPath.section {
        case 1:
            
            selectedFilter["Distance"] = filterData["Distance"]?[indexPath.row]
            isExpand["Distance"] = !isExpand["Distance"]!
        case 2:
            
            selectedFilter["Sort"] = filterData["Sort"]?[indexPath.row]
            isExpand["Sort"] = !isExpand["Sort"]!
        case 3:
            
            selectedFilter["Category"] = filterData["Category"]?[indexPath.row]
            isExpand["Category"] = !isExpand["Category"]!
        default:
            break
        }
        
        print(selectedFilter)
        
        tableView.reloadData()
    }
}
