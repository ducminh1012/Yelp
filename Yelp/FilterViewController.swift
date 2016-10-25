//
//  FilterViewController.swift
//  Yelp
//
//  Created by Kyou on 10/22/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

protocol SearchButtonDelegate: class {
    func didSearchWithData(_  data: [String: (IndexPath, String)], haveDeal: Bool, category: [String])
}

class FilterViewController: UIViewController {

    weak var searchDelegate: SearchButtonDelegate!
    
    var isFiltered = ["Distance": false, "Sort": false, "Category": false]
    var haveDeal = false
    
    var isExpand = ["Distance": false, "Sort": false, "Category": false]
    var filterData = ["Distance": ["0.3", "1", "2", "3", "4", "5"],
                          "Sort": ["Best matched", "Distance", "Hightest rated"],
                          "Category": ["American", "Asian Fusion", "Chinese"]]

    
    var selectedFilter = [String: (IndexPath, String)]()
//    var categorySelected = [IndexPath: Bool]()
    var selectedCategory = [String]()
    
    @IBOutlet weak var filterTableView: UITableView!
    @IBAction func onCancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSearchButton(_ sender: UIBarButtonItem) {

        
        searchDelegate.didSearchWithData(selectedFilter, haveDeal: haveDeal, category: selectedCategory)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        filterTableView.delegate = self
        filterTableView.dataSource = self
        
        selectedFilter = ["Distance": (IndexPath(row: 0, section: 0),""), "Sort": (IndexPath(row: 0, section: 1),""), "Category": (IndexPath(row: 0, section: 2),"")]
//        categorySelected = [IndexPath(row: 0, section: 0): false, IndexPath(row: 1, section: 0): false, IndexPath(row: 2, section: 0): false]
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
            filterCell.dealCellDelegate = self
            filterCell.selectedBackgroundView = UIView()
            return filterCell
        // Distance
        case 1:
            let filterCell2 = tableView.dequeueReusableCell(withIdentifier: "filterCell2") as! FilterCell2
            
            let index = selectedFilter["Distance"]?.0
            
            if indexPath.row ==  index?.row || (indexPath.row == 0 && isFiltered["Distance"]!){
                filterCell2.checkButton.setImage(UIImage(named: "check"), for: .normal)
            }else{
                filterCell2.checkButton.setImage(UIImage(named: "uncheck"), for: .normal)
            }
            
            
            filterCell2.distanceLabel.text = isFiltered["Distance"]! ? selectedFilter["Distance"]!.1 + " miles": filterData["Distance"]![indexPath.row] + " miles"
            filterCell2.selectedBackgroundView = UIView()
            return filterCell2
        // Sort
        case 2:
            let filterCell2 = tableView.dequeueReusableCell(withIdentifier: "filterCell2") as! FilterCell2
            
            let index = selectedFilter["Sort"]?.0
            
            if indexPath.row ==  index?.row || (indexPath.row == 0 && isFiltered["Sort"]!){
                filterCell2.checkButton.setImage(UIImage(named: "check"), for: .normal)
            }else{
                filterCell2.checkButton.setImage(UIImage(named: "uncheck"), for: .normal)
            }
            
            filterCell2.distanceLabel.text = isFiltered["Sort"]! ? selectedFilter["Sort"]?.1 : filterData["Sort"]?[indexPath.row]
            filterCell2.selectedBackgroundView = UIView()
            return filterCell2
        // Category
        case 3:
            let filterCell = tableView.dequeueReusableCell(withIdentifier: "filterCell") as! FilterCell
            filterCell.dealCellDelegate = self
            let index = selectedFilter["Category"]?.0

            
            filterCell.titleLabel.text = isFiltered["Category"]! ? selectedFilter["Category"]?.1 : filterData["Category"]?[indexPath.row]
            filterCell.selectedBackgroundView = UIView()
            return filterCell
        default:
            let filterCell2 = tableView.dequeueReusableCell(withIdentifier: "filterCell2") as! FilterCell2
            filterCell2.selectedBackgroundView = UIView()
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
            
            if !isExpand["Distance"]! {
                isFiltered["Distance"] = false
                
            }else{
                selectedFilter["Distance"]?.0 = indexPath
                selectedFilter["Distance"]?.1 = filterData["Distance"]![indexPath.row]
                isFiltered["Distance"] = true
            }
            isExpand["Distance"] = !isExpand["Distance"]!
            
        case 2:
            
            if !isExpand["Sort"]! {
                isFiltered["Sort"] = false
                
            }else{
                selectedFilter["Sort"]?.0 = indexPath
                selectedFilter["Sort"]?.1 = filterData["Sort"]![indexPath.row]
                isFiltered["Sort"] = true
            }
            isExpand["Sort"] = !isExpand["Sort"]!
        case 3:
            if !isExpand["Category"]! {
                isFiltered["Category"] = false
                
            }else{
                selectedFilter["Category"]?.0 = indexPath
                selectedFilter["Category"]?.1 = filterData["Category"]![indexPath.row]
                isFiltered["Category"] = true
            }
            isExpand["Category"] = !isExpand["Category"]!
        default:
            break
        }
        
        print(selectedFilter)
        
        tableView.reloadData()
    }
}

extension FilterViewController : DealCellDelegate{
    func switchValueChange(value: Bool, sender: UITableViewCell) {
        
        let indexPath = self.filterTableView.indexPath(for: sender)!
        
        if indexPath.section == 0{
            
            haveDeal = value
        }else{
            
            let category = filterData["Category"]?[indexPath.row]
            
            if selectedCategory.contains(category!) {
                selectedCategory.remove(at: selectedCategory.index(of: category!)!)
            }else{
                selectedCategory.append((filterData["Category"]?[indexPath.row])!)
            }
        }
        
    }
}
