//
//  EditVocabularyVCTests.swift
//  ProtoKanjiAppV.3Tests
//
//  Created by Mohammed Qureshi on 2021/10/18.
//

import XCTest

@testable import ProtoKanjiAppV_3

class EditVocabularyTests: XCTestCase {
    
    private var sutEditVC: EditViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        sutEditVC = EditViewController()
        
        sutEditVC = storyboard.instantiateViewController(identifier: String(describing: EditViewController.self))

    }
    
    override func tearDown() { //Instance member 'sutEditVC' cannot be used on type 'EditVocabularyTests' FUNC NOT CLASS FUNC
        
        sutEditVC = nil
        
        super.tearDown() //perform clean up after test case ends.
    }
    
    func test_EditVCOutlets() {
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//        let sut: EditViewController = storyboard.instantiateViewController(identifier: String(describing: EditViewController.self))
        //Cannot convert value of type 'UIViewController' to specified type 'EditViewController' should be just identifier not withIdentifier
        
        sutEditVC.loadViewIfNeeded()
        
        tapButton(sutEditVC.saveChangesButton) //Outlet not connected to the IB outlet save changes button here.
        tapButton(sutEditVC.cancelChangesButton)
    }
    
    
}
