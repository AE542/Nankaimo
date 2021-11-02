//
//  AddVocabularyVCTests.swift
//  ProtoKanjiAppV.3Tests
//
//  Created by Mohammed Qureshi on 2021/10/18.
//

import XCTest
//import ViewControllerPresentationSpy

@testable import ProtoKanjiAppV_3

class AddVocabularyTests: XCTestCase {
    
//    func test_zero() {
//        XCTFail("WHY ARE YOU LATE FOR YOUR STATUS REPORT?")
//    }
    
    private var sutVocabVC: AddVocabularyViewController! //should be an optional to test it, also name it sut

    override func setUp() { //OVERRIDE FUNC NOT OVERRIDE CLASS FUNC otherwise you can't use instances in the func!
        
        super.setUp() //need to customize the initial state before beginning the tests
        sutVocabVC = AddVocabularyViewController()
    }

    override func tearDown() {

        sutVocabVC = nil

        super.tearDown()
    }
    
    func test_AddVCOutlets() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let sut: AddVocabularyViewController = storyboard.instantiateViewController(identifier: String(describing: AddVocabularyViewController.self))
        
        sut.loadViewIfNeeded()
        
        //Button Values
        XCTAssertNotNil(sut.addNewWordText, "Add New Word Button")
        XCTAssertNotNil(sut.cancelButtonText, "Cancel Button")
        
        //Test Button Presses
        tapButton(sut.addNewWordText)
        tapButton(sut.cancelButtonText)
}
}
