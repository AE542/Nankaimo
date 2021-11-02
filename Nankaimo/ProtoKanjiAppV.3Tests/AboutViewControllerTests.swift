//
//  AboutViewControllerTests.swift
//  ProtoKanjiAppV.3Tests
//
//  Created by Mohammed Qureshi on 2021/10/18.
//

import XCTest

@testable import ProtoKanjiAppV_3

class AboutViewControllerTests: XCTestCase {
    
    private var sutAboutVC: AboutViewController!
    
    override func setUp() {
        super.setUp()
        sutAboutVC = AboutViewController()
    }
    
    override func tearDown() {
        sutAboutVC = nil
        super.tearDown()
    }
    
    func test_aboutVC_Buttons() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let sut: AboutViewController = storyboard.instantiateViewController(identifier: String(describing: AboutViewController.self))
        
        sut.loadViewIfNeeded()
        
        tapButton(sut.emailDevButton) //keep getting nil errors because you didn't connect the outlets with loadviewIfNeeded!!
        tapButton(sut.licencesButton)
        tapButton(sut.backButton)
    }
}
