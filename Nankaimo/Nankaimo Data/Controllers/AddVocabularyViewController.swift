//
//  AddVocabularyViewController.swift
//  ProtoKanjiAppV.3
//
//  Created by Mohammed Qureshi on 2021/02/04.


import UIKit
import CoreData

protocol passNewWordData: AnyObject {

    func passDataBack(data: VocabInfo) // brackets aren't required for functions in Protocols

}
//pass back the data using this protocol and calling it as a delegate


let mainVC = MainViewController()

class AddVocabularyViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet private(set) var modalView: UIView!
    
    @IBOutlet private(set) var addNewWordText: UIButton!
    
    @IBOutlet private(set)var cancelButtonText: UIButton!
    
    //@IBOutlet weak var instructionLabel: UILabel!
    
    @IBOutlet weak var vocabTextField: UITextField!
    
    @IBOutlet weak var hiraganaTextField: UITextField!
    
    @IBOutlet weak var englishTranslationTextField: UITextField!
  
    
    @IBOutlet weak var secondaryStackViewCentreY: NSLayoutConstraint!
    var secondaryStackViewCentreYConstant: CGFloat = 0
    
    @IBOutlet weak var secondaryStackViewCentreX: NSLayoutConstraint!
    var secondaryStackViewCentreXConstant: CGFloat = 0
    
     weak var delegate: passNewWordData?
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let instructionLabelAppearance = instructionLabel {
//            mainVC.addBorder(label: instructionLabelAppearance)
//        }

        if let addButtonAppearance = addNewWordText {
            mainVC.addButtonBorder(button: addButtonAppearance)
        }
        
        if let cancelButtonAppearance = cancelButtonText{
            mainVC.addButtonBorder(button: cancelButtonAppearance)
        }
        
        vocabTextField.delegate = self
        hiraganaTextField.delegate = self
        englishTranslationTextField.delegate = self
        //we need these delegates here as self so when the user presses enter on the keyboard it will be dismissed.
        
        //Listen for keyboard
       NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //dispose of any resources that can be recreated.
    }
    //MARK: - TextField Methods.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        vocabTextField.resignFirstResponder()
        hiraganaTextField.resignFirstResponder()
        englishTranslationTextField.resignFirstResponder()
        //resignFirstResponder is for when the textfield has finished being used and can then be dismissed.
        
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5) {
            self.secondaryStackViewCentreX.constant = self.secondaryStackViewCentreXConstant
      
            self.view.layoutIfNeeded()
        }
        return true
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        vocabTextField.resignFirstResponder()
        hiraganaTextField.resignFirstResponder()
        englishTranslationTextField.resignFirstResponder()

        self.view.layoutIfNeeded()

        UIView.animate(withDuration: 0.5) {
            self.secondaryStackViewCentreX.constant = self.secondaryStackViewCentreXConstant
            self.view.layoutIfNeeded()
            
        }
    }

    @objc func keyboardWillShowNotification(notification: NSNotification) {
        if let info = notification.userInfo {

            let rect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect // height of the keyboard
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.25) {
                
                self.secondaryStackViewCentreX.constant = rect.height - 425 //works but is causing constraints to be broken on when changing keyboards
                self.view.layoutIfNeeded()
            }
        }
    }

    
    @IBAction func addNewWord(_ sender: UIButton) {
        
        //For Testing
        print(">> Add New Word Was Tapped.")
        
        guard let vocabText = vocabTextField.text, vocabTextField.hasText else {
            print("Error no data")
            
            Alert.showWarningAlertController(on: self, with: "Missing Vocabulary Word! ", message: "Please fill in the Vocabulary field")
            return
        }
        
        guard let hiraganaText = hiraganaTextField.text, hiraganaTextField.hasText else {
            print("Error no hiragana entered")
          
            Alert.showWarningAlertController(on: self , with: "Missing hiragana! ", message: "Please fill in the Hiragana field")
            
            return
        }
        guard let englishTranslationText = englishTranslationTextField.text, englishTranslationTextField.hasText else {

            
            Alert.showWarningAlertController(on: self, with: "Missing English Translation! ", message: "Please fill in the English Translation field")
            print("Error no english translation entered.")
            
            return
        }
        
        //better to have guard lets to handle the data so conditions are correct before passing the data..

        let newVocabWord = VocabInfo(context: mainVC.context)
        
        newVocabWord.englishTranslation = englishTranslationText
        newVocabWord.vocabHiragana = hiraganaText
        newVocabWord.vocabTitle = vocabText
        newVocabWord.numberOfTimesSeen = 0
       
        delegate?.passDataBack(data: newVocabWord)
        
        self.dismiss(animated: true)
        //adding this dismissed the add vc from the search vc.
        
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        print(">> Cancel Button Tapped")
//
        //assert(true, "Cancel Button Tapped")
        
        self.dismiss(animated: true, completion: nil)

    }

}
