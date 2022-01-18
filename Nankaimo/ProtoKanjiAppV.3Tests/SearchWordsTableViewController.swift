//
//  SearchWordsTableViewController.swift
//  ProtoKanjiAppV.3Tests
//
//  Created by Mohammed Qureshi on 2021/12/23.
//


import XCTest

@testable import ProtoKanjiAppV_3

class SearchWordsTableViewControllerTests: XCTestCase {
    //Be careful when naming tests! Make sure the class name is the name of the class with tests added!! if its just the name of the view controller it causes tons of conflicts. Before it was just SearchTableViewController which was causing problems, now it has Tests added and is working propery in the setUp() func.

    private var sutTableVC: SearchTableViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sutTableVC = SearchTableViewController()

        sutTableVC = storyboard.instantiateViewController(identifier: String(describing: SearchTableViewController.self))

        sutTableVC.loadViewIfNeeded()
    }
    
    override func tearDown() {
        
        sutTableVC = nil
        
        super.tearDown()
    }
    
    func test_tableViewDelegates_shouldBeConnected() {
        XCTAssertNotNil(sutTableVC.tableView.dataSource, "dataSource")
        XCTAssertNotNil(sutTableVC.tableView.delegate, "delegate")
    }
    
    
    func test_numberOfRows_shouldBe1(){
        XCTAssertEqual(numberOfRows(in: sutTableVC.tableView), 1)
    }
    
    func test_cellForRowAt0_shouldSetCellLabelToDoRyoKu() {
        let cell = cellForRowAt(in: sutTableVC.tableView, row: 0) //declare cell at the row to test
        XCTAssertEqual(cell?.textLabel?.text, "努力する, どりょくする, Effort")
    }

    func test_tableViewRow0_shouldBeSelected() {
        didSelectRow(in: sutTableVC.tableView, row: 0)
    }
}
