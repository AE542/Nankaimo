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
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        sutVocabVC = storyboard.instantiateViewController(identifier: String(describing: AddVocabularyViewController.self))
        
        //DON'T FORGET TO INSTANTIATE THE STORYBOARD HERE OTHERWISE YOU'LL KEEP GETTING NIL ERRORS FOR THE TEXTFIELDS!!!! There's nothing to load so it crashes with a nil error, (for the vocabTextField when you tested it)
         
        sutVocabVC.loadViewIfNeeded()
    }

    override func tearDown() {

        sutVocabVC = nil

        super.tearDown()
    }
    
    func test_AddVCOutlets() {
        //remember don't create an sut in each function, just set one up in setUp() and don't forget to deinit in tearDown()
        
        //Button Values
        XCTAssertNotNil(sutVocabVC.addNewWordText, "Add New Word Button")
        XCTAssertNotNil(sutVocabVC.cancelButtonText, "Cancel Button")
        
        //Test Button Presses
        tapButton(sutVocabVC.addNewWordText)
        tapButton(sutVocabVC.cancelButtonText)
        
        //test Textfields aren't nil
        
        XCTAssertNotNil(sutVocabVC.vocabTextField, "vocabTextField")
        XCTAssertNotNil(sutVocabVC.hiraganaTextField, "hiraganaTextfield")
        XCTAssertNotNil(sutVocabVC.englishTranslationTextField, "englishTranslationTextField")
        
}
    
    //test that text field resigns itself and the next text field is the first responder. Remember we can create a test helper to make sure that the next test field is returned.
    
    func test_hittingReturnOnVocabTextField_shouldPutFocusOnHiraganaTextField() {
        putInViewHierarchy(sutVocabVC)
        
        sutVocabVC.vocabTextField.text = "Test"
        

        shouldReturn(in: sutVocabVC.vocabTextField) //the field where you press the return key

        XCTAssertTrue(sutVocabVC.hiraganaTextField.isFirstResponder) //first responder should be the hiragana field
    }
    
//    we need to test that the attributes are set in the textfield are set
//    I know why this is causing a nil error because there's no data inputted into the text fields to trigger the return key! So you need to write some test data for adding words.
//    Need to create a mock Data model to add the words!
    
//    func test_englishTranslationTextField_attributesShouldBeSet() {
//        guard let textfield = sutVocabVC.englishTranslationTextField else {
//            return
//        }
//        //Thread 1: Fatal error: Unexpectedly found nil while unwrapping an Optional value
//        XCTAssertEqual(textfield.autocorrectionType, .yes, "autocorrectionType")
//        XCTAssertEqual(textfield.enablesReturnKeyAutomatically, true)
//    }
}
