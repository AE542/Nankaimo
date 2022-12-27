//
//  StartMenuVCTests.swift
//  ProtoKanjiAppV.3Tests
//
//  Created by Mohammed Qureshi on 2021/10/18.
//

import Foundation

@testable import ProtoKanjiAppV_3
import XCTest
import ViewControllerPresentationSpy


class StartMenuViewControllerTests: XCTestCase { //don't forget XCTestCase not XCTest! otherwise it won't fire the test!
    
    private var sutStartMenuVC: StartViewController!
    
    override func setUp() {
        super.setUp()
        
        //setUp for Start menu
        sutStartMenuVC = StartViewController()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        sutStartMenuVC = storyboard.instantiateViewController(identifier: String(describing: StartViewController.self))
        //DON'T FORGET String DESCRIBING the start vc otherwise it won't initialise properly and cause a nil error when trying to access buttons
        
        //just set up start menu once here then you don't need to call it again and again for each test.
        
        sutStartMenuVC.loadViewIfNeeded()

    }
    
    override func tearDown() {
        executeRunLoop()
        sutStartMenuVC = nil
        
        super.tearDown()
    }
    
    func test_StartMenuVC_buttons() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//        let sut: StartViewController = storyboard.instantiateViewController(identifier: String(describing: StartViewController.self))
//
//        sut.loadViewIfNeeded()
        
        tapButton(sutStartMenuVC.startButton) //Value of type 'UIViewController' has no member 'startButton' reason why this is happening is that you didn't declare the sut: StartViewController in the above constant. Before it was sut = storyboard...
        //unrecognized selector sent to instance error AGAIN because too many touch up inside events assigned to start button.
        tapButton(sutStartMenuVC.addWordsButton)
        tapButton(sutStartMenuVC.howToUseButton)
        tapButton(sutStartMenuVC.searchWordsButton)
        tapButton(sutStartMenuVC.aboutButton)
        
    }
    
    
    func test_pressingStartButton_shouldGoToMainViewController() {

//        let navigationController = UINavigationController(rootViewController: sutStartMenuVC)
//        //create a nav controller to test if the navigation stack is picking up both the navVC and the StartMenuVC.
//
//        tapButton(sutStartMenuVC.startButton)
//
//        executeRunLoop()
//        //Remember we need this before checking assertions and its good practice to write this in the TestHelpers section.
//
//        XCTAssertEqual(navigationController.viewControllers.count, 2, "navigation stack")
//        //OK seems to be running and shows the start button was pressed in the logs.
//
//        let pushedFromCodeStartMenu = navigationController.viewControllers.last
//
//        guard let mainVC = pushedFromCodeStartMenu as? MainViewController else {
//            XCTFail("Expected MainVC" + "but got \(String(describing: mainVC))")
//
//            return
//        }
// the red 0 coming up in the right panel means this wasn't initialised to be checked...

        
        //should be segue-based push navigation
        let presentationVerifier = PresentationVerifier()
        
        putInWindow(sutStartMenuVC)
        
        tapButton(sutStartMenuVC.startButton)
        
        let segueMainVC: MainViewController? = presentationVerifier.verify(animated: true, presentingViewController: sutStartMenuVC)
        
        XCTAssertEqual(segueMainVC?.enterButton.currentTitle, "Enter")

    }

    func test_pressingSearchWordsButton_shouldGoToAddVocabularyViewController() {
        let presentationVerifier = PresentationVerifier()
        
        putInWindow(sutStartMenuVC)
        tapButton(sutStartMenuVC.addWordsButton)
        
        let segueAddVocabVC: AddVocabularyViewController? = presentationVerifier.verify(animated: true, presentingViewController: sutStartMenuVC)
        
        XCTAssertEqual(segueAddVocabVC?.title, "AddVocabularyViewController")
    }
    
    func test_pressingSearchWordsButton_shouldGoToSearchViewController() {
        
        //need to do this again to test segue based transition not code based!
        
//        let navigationController = UINavigationController(rootViewController: sutStartMenuVC)
//        //create a nav controller to test if the navigation stack is picking up both the navVC and the StartMenuVC.
//
//        tapButton(sutStartMenuVC.searchWordsButton)
//
//        executeRunLoop()
//        //Remember we need this before checking assertions and its good practice to write this in the TestHelpers section.
//
//        XCTAssertEqual(navigationController.viewControllers.count, 2, "navigation stack")
//
//        let pushedFromCodeSearchMenu = navigationController.viewControllers.last
//
//        guard let searchVC = pushedFromCodeSearchMenu as? SearchTableViewController else {
//            XCTFail("Expected searchVC" + "but got \(String(describing: pushedFromCodeSearchMenu))")
//
//            return
//        }
//
//        XCTAssertEqual(searchVC.title, nil)
        
        let presentationVerifier = PresentationVerifier()
        
        putInWindow(sutStartMenuVC)
        
        tapButton(sutStartMenuVC.searchWordsButton)
        
        let segueSearchVC: SearchTableViewController? = presentationVerifier.verify(animated: true, presentingViewController: sutStartMenuVC)
        
        XCTAssertEqual(segueSearchVC?.title, "Search Words")

    }
    
    func test_pressinghowToUseButton_shouldGoHowToUseViewController() {

        //sutStartMenuVC.loadViewIfNeeded()

//        let navigationController = UINavigationController(rootViewController: sutStartMenuVC)
//        //create a nav controller to test if the navigation stack is picking up both the navVC and the StartMenuVC.
//
//        tapButton(sutStartMenuVC.aboutButton)
//
//        executeRunLoop()
//        //Remember we need this before checking assertions and its good practice to write this in the TestHelpers section.
//
//        XCTAssertEqual(navigationController.viewControllers.count, 2, "navigation stack")
//        //Failing because you're using the push code to check here while you should be testing modally!
//

        
        let presentationVerifier = PresentationVerifier()
        putInWindow(sutStartMenuVC) //crucial you added the test helper to get the view to show in a UIWindow for tests.
        
        tapButton(sutStartMenuVC.howToUseButton)
        
        let howToUseVC: HowToUseViewController? = presentationVerifier.verify(animated: true, presentingViewController: sutStartMenuVC)
        
        XCTAssertEqual(howToUseVC?.closeButton.currentTitle, "Close")
        
        //seemed to init? and deinit in the logs.

    }
    
   func test_pressingAboutButton_shouldGoAboutViewController() {
    let presentationVerifier = PresentationVerifier()
    putInWindow(sutStartMenuVC)
    
    tapButton(sutStartMenuVC.aboutButton)
    
    let aboutVC: AboutViewController? = presentationVerifier.verify(animated: true, presentingViewController: sutStartMenuVC)
    
       XCTAssertEqual(aboutVC?.backButton.currentTitle, "Back")
    
   }
    
}
