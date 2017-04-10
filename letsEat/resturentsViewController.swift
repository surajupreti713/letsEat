//
//  resturentsViewController.swift
//  letsEat
//
//  Created by Prashant Bhandari on 3/29/17.
//  Copyright © 2017 Prashant Bhandari. All rights reserved.
//

import UIKit

class resturentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    var businesses: [Business]!
    let searchBar = UISearchBar()
    private var searchTerm = "Indian restaurant"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        //tableView.rowHeight = UITableViewAutomaticDimension
        //tableView.estimatedRowHeight = 120
        
        
        self.searchBar.placeholder = "Search anything"
        self.searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        Business.searchWithTerm(term: "\(self.searchTerm)", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.tableView.reloadData()
        }
        )
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchTerm = searchBar.text!
        Business.searchWithTerm(term: "\(self.searchTerm)", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.tableView.reloadData()
        }
        )
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let businesses = businesses {
            print(businesses.count)
            return businesses.count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        cell.business = businesses[indexPath.row]
        return cell
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "mapDisplay" {                               //segue for showing map
//            let mapViewController = segue.destination as! mapViewController
//            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
//            mapViewController.business = businesses[(indexPath?.row)!]
//        }
//        
//        //        if (segue.identifier == "detailedView"){
//        //            // Get the new view controller using segue.destinationViewController.
//        //            // Pass the selected object to the new view controller.
//        //            let cell = sender as! BusinessCell
//        //            let indexPath = tableView.indexPath(for: cell)
//        //            let business = businesses![(indexPath?.row)!]
//        //
//        //            let detailViewController = segue.destination as! DetailViewController
//        //            detailViewController.business = business
//        //        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let detailViewController = navigationController.topViewController as! RestaurantDetailsViewController
        detailViewController.business = businesses[(tableView.indexPathForSelectedRow?.row)!]
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
