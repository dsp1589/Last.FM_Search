//
//  Last_FMTests.swift
//  Last.FMTests
//
//  Created by Dhanasekarapandian Srinivasan on 9/7/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import XCTest
@testable import Last_FM

class Last_SearchTableDelegatorTests: XCTestCase {
    
    let searchTableDelegator = SearchTableDelegator()

    override func setUpWithError() throws {
        print("Set up")
    }

    override func tearDownWithError() throws {
        print("tear down")
    }

    func testSearchTableDelegatorState_numberOfRowsIdle() throws {
        searchTableDelegator.currentState = .idle
        XCTAssert(searchTableDelegator.tableView(UITableView(), numberOfRowsInSection: 0) == 0, "SearchTableDelegator no of rows condition failed for \(SearchState.idle)")
    }
    
    func testSearchTableDelegatorState_numberOfRowsSearching() throws {
        searchTableDelegator.currentState = .searching
        XCTAssert(searchTableDelegator.tableView(UITableView(), numberOfRowsInSection: 0) == 1, "SearchTableDelegator no of rows condition failed for \(SearchState.searching)")
    }
    
    func testSearchTableDelegatorState_numberOfRowsComplete_NoData() throws {
        searchTableDelegator.currentState = .completed
        XCTAssert(searchTableDelegator.tableView(UITableView(), numberOfRowsInSection: 0) == 0, "SearchTableDelegator no of rows condition failed for \(SearchState.searching)")
    }
    
    func testSearchDelegatorCellReturnForState_Idle() throws {
        searchTableDelegator.currentState = .searching
        
        let controller = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "SearchTableViewController")
        let tbv = controller.view as! UITableView
        let c = searchTableDelegator.tableView(tbv, cellForRowAt: IndexPath.init(item: 0, section: 0))
        
        XCTAssert( c.viewWithTag(777) is UIActivityIndicatorView, "Wrong cell returned for state idle")
    }

}
