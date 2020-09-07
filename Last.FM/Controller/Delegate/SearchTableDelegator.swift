//
//  SearchTableDelegator.swift
//  Last.FM
//
//  Created by Dhanasekarapandian Srinivasan on 9/6/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import Foundation
import UIKit


protocol NavigatableSearch {
    func didTapItem(idx: Int)
}


class SearchTableDelegator: NSObject, UITableViewDelegate {
    
    weak var model: SearchResultsTableViewModel?
    var currentState: SearchState = .idle
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        model?.didTapItem(idx: indexPath.row)
    }

}

extension SearchTableDelegator: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentState == .searching { return 1 }
        else if currentState == .idle { return 0 }
        return model?.totalRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if currentState == .searching {
            let c = tableView.dequeueReusableCell(withIdentifier: "loadingIdentifier")!
            (c.viewWithTag(777) as? UIActivityIndicatorView)?.startAnimating()
            return c
        }
        
        guard let c = tableView.dequeueReusableCell(withIdentifier: "searchedItem") as? SearchResultTableViewCell else {
            return UITableViewCell()
        }
        
        c.configureData(imageUrl: model?.imageURL(idx: indexPath.row) ?? "", albArtist: model?.titleText(idx: indexPath.row), albArtistSub: model?.subTitleText(idx: indexPath.row))
        return c
    }
}
