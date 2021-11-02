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

        if let emailDevButtonAppearance = emailDevButton {
            mainVC.addButtonBorder(button: emailDevButtonAppearance)
        }
        
        if let licensesButtonAppearance = licencesButton {
            mainVC.addButtonBorder(button: licensesButtonAppearance)
        }
        
        if let aboutTextViewAppearance = aboutTextView {
            aboutTextViewAppearance.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).cgColor
            aboutTextViewAppearance.layer.borderWidth = 2.5
            aboutTextViewAppearance.layer.cornerRadius = 10.0

            aboutTextViewAppearance.font?.withSize(20.0)
            
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
        
    
        if let backButtonAppearance = backButton {
            mainVC.addButtonBorder(button: backButtonAppearance)
        }

}
    @IBAction func emailButton(_ sender: UIButton) {
        
        print(">> Email Dev button pressed")
        
        let email = "mqdev4621064@gmail.com"
        if let url = URL(string: "mailto:\(email)") {
          if #available(iOS 10.0, *) {
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

        print("Licesnses Button pressed")
        //let lines = linesFromResourceForced(fileName: "Licenses.txt")
        let path = Bundle.main.path(forResource: "Licenses.txt", ofType: nil)!
        let content = try! String(contentsOfFile: path, encoding: String.Encoding.utf8)
        
        let ac = UIAlertController(title: "Licenses", message: content, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
      //ac.setValue(fullString, forKey: "attributedTitle")
        self.present(ac, animated: true)
        
    }
    //MIT Licenses showing up now.
    
//    func linesFromResourceForced(fileName: String) -> [String] {
//
//        let path = Bundle.main.path(forResource: fileName, ofType: nil)!
//        let content = try! String(contentsOfFile: path, encoding: String.Encoding.utf8)
//        return content.components(separatedBy: "\n")
//       }
    
    
    @IBAction func backButton(_ sender: UIButton) {
        
        print("Back button pressed")
        
        self.dismiss(animated: true, completion: nil)
       
    }
}
