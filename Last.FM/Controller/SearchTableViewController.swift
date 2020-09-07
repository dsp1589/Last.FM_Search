//
//  SearchTableViewController.swift
//  Last.FM
//
//  Created by Dhanasekarapandian Srinivasan on 9/5/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import Foundation
import UIKit



class SearchTableViewController: UITableViewController {
    
    private let searchViewModel = SearchResultsTableViewModel()
    private let scopesTitle = Scope.allCases.map{$0.rawValue}
    
    private var searchController:UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchViewModel.controller = self
        setUpSearchController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpTableView()
    }
    
    private func setUpSearchController(){
        searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.delegate = self
        searchController.searchBar.scopeButtonTitles = scopesTitle
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    private func setUpTableView(){
        tableView.delegate = searchViewModel.delegator
        tableView.dataSource = searchViewModel.delegator
    }
    
}

extension SearchTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchableText = searchController.searchBar.text, searchableText.count >= 1 else { return }
        searchViewModel.searchQueryUpdate(text: searchableText)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
            searchViewModel.scopeIndex = selectedScope
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.selectedScopeButtonIndex = 0
        searchViewModel.scopeIndex = 0
        searchViewModel.reset()
    }
}


extension SearchTableViewController {
    func showInfo(searchPaarams: [String:String], type: SearchType){
        let v = DetailsViewController(params: searchPaarams, type: type)
        self.navigationController?.pushViewController(v, animated: true)
    }
}
