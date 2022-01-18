//
//  AboutViewController.swift
//  ProtoKanjiAppV.3
//
//  Created by Mohammed Qureshi on 2021/04/30.
//


//2021/08/02 Added Alert controller with MIT License for use of TableViewReload
import UIKit
//import Licenses

class AboutViewController: UIViewController {


    @IBOutlet private(set) var emailDevButton: UIButton!
    @IBOutlet private(set) var backButton: UIButton!
    @IBOutlet private(set) var aboutTextView: UITextView!
    @IBOutlet private(set) var licencesButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        if let emailDevButtonAppearance = emailDevButton, let licensesButtonAppearance = licencesButton, let backButtonAppearance = backButton {
            let buttons = [emailDevButtonAppearance, licensesButtonAppearance, backButtonAppearance]
            for button in buttons {
                mainVC.addButtonBorder(button: button)
                button.startAnimatingPressActions()
            }

        }

        
        if let aboutTextViewAppearance = aboutTextView {
            aboutTextViewAppearance.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).cgColor
            aboutTextViewAppearance.layer.borderWidth = 2.5
            aboutTextViewAppearance.layer.cornerRadius = 10.0

            aboutTextViewAppearance.font?.withSize(20.0)
            
            aboutTextViewAppearance.textAlignment = .center
            
            aboutTextViewAppearance.text = """
                
                I'm a self taught developer who wanted to try and make something that could be useful for people learning Japanese.
                
                This app was made in my spare time and days off and I hope to add more features to it in the future.
                
                If you have any suggestions, ways to improve the app, or would like to contact me, please forward any queries to:
                
                mqdev4621064@gmail.com
                
                or by selecting the Email Developer Button below.
                
                If you liked this app or want to leave a review, please do so on the AppStore, I'd really appreciate any feedback.
                
                Thanks for trying out Nankaimo!
                
                """

    }
        

}
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        super.viewWillAppear(true)
    }
    
    @IBAction func emailButton(_ sender: UIButton) {
        
        print(">> Email Dev button pressed")
        
        let email = "mqdev4621064@gmail.com"
        if let url = URL(string: "mailto:\(email)") {
          if #available(iOS 12.0, *) {
            UIApplication.shared.open(url)
          } else {
            UIApplication.shared.openURL(url)
          }
        }
        //method for opening the email client.
    }
    
//add pop up for licenses for TableView reload animation
    
   // let lines = linesFromResourceForced("Licenses.txt")
    
    @IBAction func licensesButton(_ sender: UIButton) {

        print("Licenses Button pressed")
        //let lines = linesFromResourceForced(fileName: "Licenses.txt")
        let path = Bundle.main.path(forResource: "Licenses.txt", ofType: nil)!
        let content = try! String(contentsOfFile: path, encoding: String.Encoding.utf8)
        
        let ac = UIAlertController(title: "Licenses", message: content, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
      //ac.setValue(fullString, forKey: "attributedTitle")
        self.present(ac, animated: true)
        
    }
    //MIT Licenses showing up now.
    
    @IBAction func backButton(_ sender: UIButton) {
        
        print("Back button pressed")
        
        self.dismiss(animated: true, completion: nil)
       
    }
    
    func setGradientBackground() {
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
