//
//  StartViewController.swift
//  ProtoKanjiAppV.3
//
//  Created by Mohammed Qureshi on 2021/04/27.

import UIKit
import SwiftUI

class StartViewController: UIViewController {
    @IBOutlet weak var buttonStackView: UIStackView!
    
    @IBOutlet private(set) var welcomeLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet private(set) var searchWordsButton: UIButton!
    
    @IBOutlet private(set) var howToUseButton: UIButton!
    
    @IBOutlet private(set) var aboutButton: UIButton!
    
    @IBOutlet private(set) var addWordsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Main Menu"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "DINAlternate-Bold", size: 20)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes as [NSAttributedString.Key : Any]
        
        navigationController?.navigationBar.backgroundColor = UIColor(hex: 0x5F7BCF)
        //navigationController?.navigationBar.tintColor = UIColor(hex: 0x5F7BCF)
        navigationController?.navigationBar.isTranslucent = true //so the colour is visible at the top

            if let howToUseAppearance = howToUseButton, let aboutLabelAppearance = aboutButton, let startButtonAppearance = startButton, let searchWordsAppearance = searchWordsButton, let addWordsButtonAppearance = addWordsButton  {
                
                let buttons = [howToUseAppearance, addWordsButtonAppearance, searchWordsAppearance, aboutLabelAppearance, startButtonAppearance]
                for button in buttons {
                    button.startAnimatingPressActions()
                    button.isAccessibilityElement = true
                    buttons[0].accessibilityLabel = "How To Use" //test this asap
                    mainVC.addButtonBorder(button: button)
                    //far better way to refactor, reduces DRY.
                }

            }
                if let welcomeLabelAppearance = welcomeLabel {
                    mainVC.addBorder(label: welcomeLabelAppearance)
                    welcomeLabelAppearance.isAccessibilityElement = true
                    welcomeLabelAppearance.accessibilityLabel = welcomeLabelAppearance.text
                }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //welcomeLabel.backgroundColor = .blue
        setGradientBackground()
        //animateStackView()
        //welcomeLabel.fadeTransition(1.5)
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //welcomeLabel.fadeTransition(2.5)
        super.viewDidAppear(true)
       // welcomeLabel.fadeTransition(2.5)
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
    
    @IBAction func addWordButtonPressed(_ sender: UIButton) {
        print("Add A Word Button Pressed")
    }
    

    func animateStackView() {
        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseIn, animations: { //
            self.welcomeLabel.isHidden = false; self.welcomeLabel.alpha = 1.0
        
    })
    
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
extension UIView {
    func fadeTransition(_ duration: CFTimeInterval) {
        let animation = CATransition()
        
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
  
        animation.type = CATransitionType.fade
        
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}
