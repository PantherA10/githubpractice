//
//  TableViewController.swift
//  githubpractice
//
//  Created by  Scholar on 7/1/21.
//

import UIKit

class TableViewController: UITableViewController, UISearchResultsUpdating {

    let tableData = ["One", "Two", "Three", "Twenty-One"]
    var filteredTableData = [String]()
    var resultsSearchController = UISearchController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultsSearchController = ({
                        let controller = UISearchController(searchResultsController: nil)
                        controller.searchResultsUpdater = self
                        controller.searchBar.sizeToFit()
                        
                        tableView.tableHeaderView = controller.searchBar
                        
                        return controller

                    })()
        
        //Reload the table
        tableView.reloadData()

        // Do any additional setup after loading the view.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        //1
        //return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //2
        //return the number of rows
        if (resultsSearchController.isActive) {
            return filteredTableData.count
        } else {
            return tableData.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //3
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if (resultsSearchController.isActive) {
            cell.textLabel?.text = filteredTableData[indexPath.row]
            
            return cell
        } else {
            cell.textLabel?.text = tableData[indexPath.row]
            print(tableData[indexPath.row])
            return cell
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredTableData.removeAll(keepingCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (tableData as NSArray).filtered(using: searchPredicate)
        filteredTableData = array as! [String]
        
        self.tableView.reloadData()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
