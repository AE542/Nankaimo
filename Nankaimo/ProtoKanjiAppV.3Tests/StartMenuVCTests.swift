//
//  StartMenuVCTests.swift
//  ProtoKanjiAppV.3Tests
//
//  Created by Mohammed Qureshi on 2021/10/18.
//

import Foundation

@testable import ProtoKanjiAppV_3
import XCTest

class StartMenuViewControllerTests: XCTestCase { //don't forget XCTestCase not XCTest! otherwise it won't fire the test!
    
    private var sutStartMenuVC: StartViewController!
    
    override func setUp() {
        super.setUp()
        sutStartMenuVC = StartViewController()
        
    }
    
    override func tearDown() {
        
        sutStartMenuVC = nil
        
        super.tearDown()
    }
    
    func test_StartMenuVC_buttons() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let sut: StartViewController = storyboard.instantiateViewController(identifier: String(describing: StartViewController.self))
        
        sut.loadViewIfNeeded()
        
        tapButton(sut.startButton) //Value of type 'UIViewController' has no member 'startButton' reason why this is happening is that you didn't declare the sut: StartViewController in the above constant. Before it was sut = storyboard...
        //unrecognized selector sent to instance error AGAIN because too many touch up inside events assigned to start button.
        tapButton(sut.howToUseButton)
        tapButton(sut.searchWordsButton)
        tapButton(sut.aboutButton)
    }
    
}
