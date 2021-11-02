//
//  StartViewController.swift
//  ProtoKanjiAppV.3
//
//  Created by Mohammed Qureshi on 2021/04/27.
// Had to make this as a CocoaTouch class to get access to it from the IB.

import UIKit

class StartViewController: UIViewController {
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var startButtonLabel: UIButton!
    
    @IBOutlet weak var searchWordsLabel: UIButton!
    
    @IBOutlet weak var howToUseLabel: UIButton!
    
    @IBOutlet weak var aboutLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Main Menu"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "DINAlternate-Bold", size: 20)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
//      let textFontAttributes = [NSAttributedString.Key.font: UIFont(name: "DINAlternate-Bold", size: 15)!]
//        //UINavigationBar.appearance().titleTextAttributes = textFontAttributes
//        navigationController?.navigationBar.titleTextAttributes = textFontAttributes as [NSAttributedString.Key : Any]
        
       
            if let howToUseAppearance = howToUseLabel, let aboutLabelAppearance = aboutLabel, let startButtonAppearance = startButtonLabel, let searchWordsAppearance = searchWordsLabel  {
                mainVC.addButtonBorder(button: startButtonAppearance)
                mainVC.addButtonBorder(button: howToUseAppearance)
                mainVC.addButtonBorder(button: aboutLabelAppearance)
                mainVC.addButtonBorder(button: searchWordsAppearance)

            }
                if let welcomeLabelAppearance = welcomeLabel {
                    mainVC.addBorder(label: welcomeLabelAppearance)
                }
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        
    }

}
