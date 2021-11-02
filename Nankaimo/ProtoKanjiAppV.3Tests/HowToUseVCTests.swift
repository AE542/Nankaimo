//
//  InstructionsVCTests.swift
//  ProtoKanjiAppV.3Tests
//
//  Created by Mohammed Qureshi on 2021/10/18.
//

import XCTest

@testable import ProtoKanjiAppV_3

class HowToUseViewControllerTests: XCTestCase {
    
    private var sutHowToUseVC: HowToUseViewController!
    
    override func setUp() {
        
        super.setUp()
        
        sutHowToUseVC = HowToUseViewController()
        
    }
    
    override func tearDown() {
        
        sutHowToUseVC = nil
        
        super.tearDown()
        
    }
    
    func test_howToUse_Buttons() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let sut: HowToUseViewController = storyboard.instantiateViewController(identifier: String(describing: HowToUseViewController.self))
        
        sut.loadViewIfNeeded()
        
        tapButton(sut.closeButton)
    }
}
