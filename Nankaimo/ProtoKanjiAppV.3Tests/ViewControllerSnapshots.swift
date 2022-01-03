//
//  ViewControllerSnapshots.swift
//  ProtoKanjiAppV.3Tests
//
//  Created by Mohammed Qureshi on 2021/12/26.
//

//import XCTest
// DO NOT Add the iossnapshotframework to link binary with libraries section for the protoKanji app target otherwise you get the THREAD SIGBART error and the app won't launch. Make sure its removed before running tests.

import iOSSnapshotTestCase

@testable import ProtoKanjiAppV_3

class ViewControllerSnapshots: FBSnapshotTestCase {

//    func test_Zero() {
//        XCTFail("No Visual")
//    }
    
    private var sutStartMenu: StartViewController!
    
    private var sutMainVC: MainViewController!
    
    private var sutAddVC: AddVocabularyViewController!
    
    private var sutEditVC: EditViewController!
    
    private var sutHowToUseVC: HowToUseViewController!
    
    private var sutAboutVC: AboutViewController!
    
    private var sutSearchVC: SearchTableViewController!
    //this one will change a lot so might cause a ton of errors.
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sutStartMenu = storyboard.instantiateViewController(identifier: String(describing: StartViewController.self))
        
        sutMainVC = storyboard.instantiateViewController(identifier: String(describing: MainViewController.self))
        
        sutAddVC = storyboard.instantiateViewController(identifier: String(describing: AddVocabularyViewController.self))
        
        sutEditVC = storyboard.instantiateViewController(identifier: String(describing: EditViewController.self))
        
        sutHowToUseVC = storyboard.instantiateViewController(identifier: String(describing: HowToUseViewController.self))
        
        sutAboutVC = storyboard.instantiateViewController(identifier: String(describing: AboutViewController.self))
        
        sutSearchVC = storyboard.instantiateViewController(identifier: String(describing: SearchTableViewController.self))
        
       // sutStartMenu.loadViewIfNeeded()
        
        recordMode = false
        //remember you need to change this from false -> true -> false to save a snapshot image.
    }
    
    func test_appearanceOfStartMenuVC() {
        FBSnapshotVerifyViewController(sutStartMenu)
    }
    
    func test_appearanceOfMainVC() {
        FBSnapshotVerifyViewController(sutMainVC)
    }
    
    func test_appearanceOfAddVC() {
        FBSnapshotVerifyViewController(sutAddVC)
    }
    
    func test_appearanceOfEditVC() {
        FBSnapshotVerifyViewController(sutEditVC)
    }
    
    func test_appearanceOfHowToUseVC() {
        FBSnapshotVerifyViewController(sutHowToUseVC)
    }
    
    func test_appearanceOfSearchTableVC() {
        FBSnapshotVerifyViewController(sutSearchVC)
    }
    //this could be refactored into one function to test all appearances at once.
}
