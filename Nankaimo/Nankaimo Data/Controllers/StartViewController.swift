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
        
        //let backgroundColor = UIColor(hex: 0x6B8AD3)
        
        navigationController?.navigationBar.backgroundColor = UIColor(hex: 0x5F7BCF)
        //navigationController?.navigationBar.tintColor = UIColor(hex: 0x5F7BCF)
        navigationController?.navigationBar.isTranslucent = true //so the colour is visible at the top

        //self.setGradientBackground()
        //self.view.backgroundColor = .green
        //setGradientBackground()
       
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
    
    override func viewWillAppear(_ animated: Bool) {
        //welcomeLabel.backgroundColor = .blue
        setGradientBackground()
        super.viewWillAppear(animated)
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

    
    //set background colour for view
    
    public func setGradientBackground() {
        let colour1 = UIColor(hex: 0x5F7BCF).cgColor //remember hexidecimal # can be written as 0x
        let colour2 = UIColor(hex: 0x5C93D6).cgColor
        let colour3 = UIColor(hex: 0x3F9FD0).cgColor
        let colour4 = UIColor(hex: 0x1EB2CE).cgColor
        //let colour5 = UIColor(hex: <#T##Int#>)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colour1, colour2, colour3, colour4]
        //gradientLayer.colors = [UIColor.red, UIColor.black, UIColor.green, UIColor.white]

        gradientLayer.locations = [0.2, 0.4, 0.6, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}

//create an extension to handle hex values so you can call them as an extension of UIColor.
extension UIColor {
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
            )
    
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
    
    
}
