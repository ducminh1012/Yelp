//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController {
    @IBOutlet weak var yelpTableView: UITableView!

    var businesses: [Business] = [Business]()
    var searchBar = UISearchBar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        yelpTableView.delegate = self
        yelpTableView.dataSource = self

        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        yelpTableView.estimatedRowHeight = 100
        
        Business.searchWithTerm(nil, completion: { (businesses: [Business]?, error: Error?) -> Void in
            if let businesses = businesses {
                self.businesses = businesses

                
                self.yelpTableView.reloadData()
            }
        })


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension BusinessesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "yelpCell") as? YelpCell
        
        cell?.data = businesses[indexPath.row]
        
        return cell!
    }

}

extension BusinessesViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        
        Business.searchWithTerm(searchBar.text, completion: { (businesses: [Business]?, error: Error?) -> Void in
            if let businesses = businesses {
                self.businesses = businesses
               
                self.yelpTableView.reloadData()
            }
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        Business.searchWithTerm(nil, completion: { (businesses: [Business]?, error: Error?) -> Void in
            if let businesses = businesses {
                self.businesses = businesses
                self.yelpTableView.reloadData()
            }
        })
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
}
