//
//  SearchTableViewController.swift
//  MemoApp
//
//  Created by 나리강 on 2022/09/05.
//

import UIKit
import RealmSwift


class SearchTableViewController: UITableViewController {

    let localRealm = try! Realm()
    var tasks : Results<memoModel>!
    var filteredArr : Results<memoModel>!
    var searchResult : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UITableViewController().tableView.delegate = self
        UITableViewController().tableView.dataSource = self
        
        view.backgroundColor = .darkGray
        tableView.backgroundColor = .black
        let nib = UINib(nibName: "SearchTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SearchTableViewCell.reuseIdentifier)
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        
        setupSearchController()
        
        
    }

    func setupSearchController(){
        
      
       
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "검색"
        self.navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.automaticallyShowsCancelButton = true
        searchController.obscuresBackgroundDuringPresentation = true
        self.navigationController?.navigationBar.tintColor = UIColor.clear
        searchController.hidesNavigationBarDuringPresentation = false
      
        var isSearchBarEmpty : Bool {
            return searchController.searchBar.text?.isEmpty ?? true
        
        }
        searchController.searchBar.tintColor = UIColor.orange
        searchController.searchBar.searchTextField.addTarget(self, action: #selector(searchTextFieldTapped), for: .touchUpInside)
        
       
        
        
    }
    
    @objc func searchTextFieldTapped(){
        
        print(10)
  
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchResult
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
       
        return cell
    }

}

extension SearchTableViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
       
        guard let text = searchController.searchBar.text?.lowercased() else { return }
        print(text)
        filteredArr = localRealm.objects(memoModel.self).filter(text)
     
    }
    
}
