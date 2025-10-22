//
//  ViewController.swift
//  Airlines
//
//  Created by Amruth Kallyam on 5/2/25.
//

import UIKit
import Network

class ViewController: UIViewController{
    var airlineViewModel = AirlineViewModel()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self
        airlineViewModel.search(text:"American Airlines")
        airlineViewModel.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}
    
    
    extension ViewController: UITableViewDataSource{
        func numberOfSections(in tableView: UITableView) -> Int {
            return 2
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return airlineViewModel.numberOfItems(in: section)
        }
        

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AirlinesCell", for: indexPath) as? AirlineTableViewCell else {
                return UITableViewCell()
            }

            if let item = airlineViewModel.item(at: indexPath) {
                cell.urlLabel.text = item.firstUrl
                cell.txtLabel.text = item.text.components(separatedBy: " - ").first
            }

            return cell
        }

        
        
        
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return section == 0 ? "Results" : "Related Topics"
        }
        
    }
    
    
    
    
    extension ViewController: UISearchBarDelegate{
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            guard let text = searchBar.text, !text.isEmpty else { return }
            print("Searching for: \(text)")
            airlineViewModel.search(text: text)
        }
        
    }

