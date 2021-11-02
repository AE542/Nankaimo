//
//  MainViewControllerTests.swift
//  ProtoKanjiAppV.3Tests
//
//  Created by Mohammed Qureshi on 2021/09/23.
//

//Remember by convention the tests should be named the same as the class they're supposed to be testing. Also don't forget to use @testable import to get the actual target you're testing.

//2021/10/15 already did some practice with XCTAssertNotNil on button and labels, but it is also possible to test the outlet connections! So for convention's sake we can change the IBOutlets to private vars instead of weak vars (Might this cause problems with retain cycles?) but as their access level is private we can't access the labels here, so we need to change them to private(set) var

//2021/10/25 Be careful when adding the VC PresentationSpy framework. Make sure in the build phases tab you make sure the target is set to the the app name not the tests when adding it to the copy files resources drop down menu. Also testing submit and cancel buttons for the main vc Enter Button was a success...after a lot of messing around with the code. The logs show the buttons being pressed.

import XCTest
import ViewControllerPresentationSpy

@testable import ProtoKanjiAppV_3

class MainViewControllerTests: XCTestCase { //name your tests the name of the class you're testing in.

//    func test_zero() { //good convention to start every test suite with this test to make sure the basic app infrastructure is working and there are no major errors.
//        XCTFail("Testing infrastructure, this should fail.")
//    }
    
    private var sutMainVC: MainViewController! //expected name or constructor type error and can't unwrap MainVC this way... because you should use colons instead of =! Remember its ok to force unwrap them here because the value definitely exists and we must set the class to be of type var
    
    //Because we'd end up endlessly initialising this class over and over again, we need to make sure we use setUp() and tearDown() correctly
    
    //private var sutEditVC: EditViewController! //just testing this out to see if it will run remember to set it as force unwrapped var
    
    private var alertVerifier: AlertVerifier!
    
    private var sutVocabModel: VocabBuilder!
    
    //private var sutStartMenu: StartViewController!
    
    override func setUp() { //set up
        super.setUp() //override set up of main class
        sutMainVC = MainViewController() //init it within set up
        
        alertVerifier = AlertVerifier()
 
        sutVocabModel = VocabBuilder()
        
        //we can move the sut to the test fixture (this setUp() func)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sutMainVC = storyboard.instantiateViewController(identifier: String(describing: MainViewController.self))

        sutMainVC.loadViewIfNeeded()
        
    }
    
    override func tearDown() { //do not use class func it causes errors, just the func itself will do
        
        alertVerifier = nil
        
        sutMainVC = nil //set the class's value to nil
        //sutEditVC = nil
        
        sutVocabModel = nil
        
        //sutStartMenu = nil
        
        super.tearDown() //tear down (deinit) the class
    }

    
    func test_One() {
      //  let sut = MainViewController() //remember sut means 'system under test' just so you can see what is being tested.
        
        sutMainVC.callNotifications() //ok so it called the function so the test is working.
        sutMainVC.loadNewWord() //also succeeded with this func.
        sutMainVC.loadUI()
        
        //however its bad practice to put the sut inside the func as it will keep being initialised over and over again without being deinitialised. Causing memory leaks. Don't call classes inside functions without deinitialising them.
//We need to initialise the class and deinit with the setUp() and tearDown() methods. Also we can declare sut as a private var that is implicitly unwrapped. It's ok to implicitly unwrap it here.
    }
 
//    func test_EditVC() {
//       //sutEditVC.loadEditData()//values are set to nil so causes crash.
//        //sutEditVC.self]
//        XCTAssertNil(sutEditVC.editHiraganaTextField) //doesn't fail? because it's set to vocabData which has a value?\
//        //ok now it fails because editHiraganaTextField is nil til a value is passed into it by the delegate.
//    }

//        func test_mainVC_withStringAndSubmittedAnswer_shouldReturnMatch() {
////
//        let submittedAnswer = mainVC.submit(answer: "漢字") //this is not testing a return value like in iOS Unit testing by example
//            let secondSubmittedAnswer = mainVC.submit(answer: "")
//
//         let newAnswer =
//            XCTAssertEqual(submittedAnswer, secondSubmittedAnswer) //can't convert type () to a String.
//
//            //This isn't working because () cannot conform to Equatable. There's no values to compare against here...
//    }
//
//    func test_VocabModel_withreturnAllWords_shouldReturnAllValues() {
//        let modelData = vocabInfo.nextVocab()
//        XCTAssertEqual(modelData, "", )
//    }
    
//    func test_vocabArrayIsEmpty_withNil_shouldReturnEmptyIsTrue(){
//
//        let emptyVocabArray = vocabBuilder.vocabArray.isEmpty
//
//        XCTAssertEqual(emptyVocabArray, nil)
//        //XCTAssertEqual failed: ("Optional(true)") is not equal to ("nil") testing to see if the vocabArray actually is empty.
//        //If we just use XCTAssert it comes back as true as the array is empty.
//
//    }
    
//    func test_vocabModelReturnsStrings_withReturnAllWordData_shouldReturnSomething() {
//        let returnValueToTest = vocabBuilder.returnAllWordDataForN1().hiragana
//
//        XCTAssertEqual(<#T##expression1: Equatable##Equatable#>, <#T##expression2: Equatable##Equatable#>, <#T##message: String##String#>)(returnValueToTest, "")
//    }
//    //Strings have to conform to Equatable to use XCTAssertEqual
//
    
    //MARK: - Storyboard Tests
    //remember what you learnt for testing storyboard vcs
    func test_loadingMainVC_noNilValues() {
//        let sb = UIStoryboard(name: "Main", bundle: nil) //first set the view controller as is, be sure to make sure the storyboard id is the same to avoid errors.
//        //BE CAREFUL!!! Don't test the viewcontroller itself! You're supposed to be testing the Main.storyboard file! Now passes.
//        let sut: MainViewController = sb.instantiateViewController(identifier: String(describing: MainViewController.self))
//        //we need to downcast the sut to that of the MainVC above; sut: MainViewController = sb.
//
//        sut.loadViewIfNeeded()
        //remember to call this func to make sure the view and outlets are connected for testing otherwise it won't detect the labels when testing below.
        
        //MainViewControllerTests
        
        //Buttons
        XCTAssertNotNil(sutMainVC.enterButton, "Enter") //good convention to add a message so you know which assertion failed immediately.
        XCTAssertNotNil(sutMainVC.nextWordButton, "Next Word")
        
        //Labels
        XCTAssertNotNil(sutMainVC.vocabBox, "Vocabulary Box")
        XCTAssertNotNil(sutMainVC.englishTranslationBox, "English Translation Box")
        XCTAssertNotNil(sutMainVC.hiraganaBox, "Hiragana Box")
        XCTAssertNotNil(sutMainVC.viewCount, "View Count")
        
        
        
    }
    
    func test_pressingButton_shouldShowAlert() {
        tapButton(sutMainVC.enterButton)
        
        alertVerifier.verify(title: "What is 努力する in Hiragana?", message: "Enter your answer into the box below", animated: true, actions: [.default("Submit"), .cancel("Cancel")], presentingViewController: sutMainVC)
        
        //had to change the title to the current word saved at index 0. Be careful when setting actions and that the .default value should be first
        //also when testing, make sure there's only one word to check via tests here otherwise this assert failed.
        
        XCTAssertEqual(alertVerifier.preferredAction?.title, "Submit")
    }
    
    func test_executeAlertAction_withEnterButton() throws {
        
        //Remember to 
        tapButton(sutMainVC.enterButton)
        try alertVerifier.executeAction(forButton: "Submit") //nil error because you didn't declare AlertVerifier in the setUp() Also the name should be the name of the button! Submit!
    }
    
    func test_executeAlertAction_withCancelButton() throws {
        tapButton(sutMainVC.enterButton)
        try alertVerifier.executeAction(forButton: "Cancel")
    }
    
    
//    func test_AddVCOutlets() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        
//        let sut: AddVocabularyViewController = storyboard.instantiateViewController(identifier: String(describing: AddVocabularyViewController.self))
//        
//        sut.loadViewIfNeeded()
//        
//        //Buttons
//        XCTAssertNotNil(sut.addNewWordText)
//        XCTAssertNotNil(sut.cancelButtonText)
//        
//        //Labels
//       // XCTAssertNotNil(sut.instructionLabel, "Instruction Label") //this is nil because it was never used!
//        
//        
//    }
    

    
}
