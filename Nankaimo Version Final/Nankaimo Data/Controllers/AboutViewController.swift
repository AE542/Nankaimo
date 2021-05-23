//
//  AboutViewController.swift
//  ProtoKanjiAppV.3
//
//  Created by Mohammed Qureshi on 2021/04/30.
//

import UIKit

class AboutViewController: UIViewController {


    @IBOutlet weak var emailDevButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var aboutTextView: UITextView!
    override func viewDidLoad() {
        
        super.viewDidLoad()

        if let emailDevButtonAppearance = emailDevButton {
            mainVC.addButtonBorder(button: emailDevButtonAppearance)
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
    
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
       
    }
}
