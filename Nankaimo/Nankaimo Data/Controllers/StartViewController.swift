//
//  StartViewController.swift
//  ProtoKanjiAppV.3
//
//  Created by Mohammed Qureshi on 2021/04/27.
// Had to make this as a CocoaTouch class to get access to it from the IB.

import UIKit

class StartViewController: UIViewController {
    @IBOutlet private(set) var welcomeLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet private(set) var searchWordsButton: UIButton!
    
    @IBOutlet private(set) var howToUseButton: UIButton!
    
    @IBOutlet private(set) var aboutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Main Menu"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "DINAlternate-Bold", size: 20)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]

        
       
            if let howToUseAppearance = howToUseButton, let aboutLabelAppearance = aboutButton, let startButtonAppearance = startButton, let searchWordsAppearance = searchWordsButton  {
                mainVC.addButtonBorder(button: startButtonAppearance)
                mainVC.addButtonBorder(button: howToUseAppearance)
                mainVC.addButtonBorder(button: aboutLabelAppearance)
                mainVC.addButtonBorder(button: searchWordsAppearance)

            }
                if let welcomeLabelAppearance = welcomeLabel {
                    mainVC.addBorder(label: welcomeLabelAppearance)
                }
    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        print("Start Button Pressed")
    }
    
    @IBAction func searchWordsPressed(_ sender: UIButton) {
        print("Search Words Button Pressed")
    }
    @IBAction func howToUseButtonPressed(_ sender: UIButton) {
        print("How To Use Button Pressed")
    }
    
    @IBAction func aboutButtonPressed(_ sender: UIButton) {
        print("About Button Pressed")
    }

}
