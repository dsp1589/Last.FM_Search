//
//  DetailsViewController.swift
//  Last.FM
//
//  Created by Dhanasekarapandian Srinivasan on 9/6/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import Foundation
import UIKit
import Nuke


class DetailsViewController: UIViewController {
    
    
    private var searchPaarams: [String: String]!
    private var searchType: SearchType!
    private var model : DetailsViewModel!
    
    convenience init(params: [String: String], type: SearchType) {
        self.init(nibName: nil, bundle: nil)
        searchPaarams = params
        searchType = type
        model = DetailsViewModel.init(searchPaarams: params, searchType: type)
    }
    
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func loadView() {
        navigationController?.navigationBar.prefersLargeTitles = false
        edgesForExtendedLayout = []
        let v = DetailsView(viewModel: model)
        v.backgroundColor = .white
        view = v
        model.view = v
    }
}
