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
    
    let viewAppearance = BackgroundColor()
    
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
        
        if let vocabText = vocabTextField, let hiraganaText = hiraganaTextField, let englishTranslation = englishTranslationTextField {
        vocabText.enablesReturnKeyAutomatically = true
        hiraganaText.enablesReturnKeyAutomatically = true
        englishTranslation.enablesReturnKeyAutomatically = true
        
        englishTranslation.autocorrectionType = .yes
        
        vocabText.delegate = self
        hiraganaText.delegate = self
        englishTranslation.delegate = self
        }
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
        if textField === vocabTextField {
            //remember === makes sure that the textfield is the one thats being used
            hiraganaTextField.becomeFirstResponder()
        } else if textField === hiraganaTextField {
            englishTranslationTextField.becomeFirstResponder()
        } else if textField === englishTranslationTextField {
            englishTranslationTextField.resignFirstResponder()
            
            self.animateStackViewWhenKeyboardResignsFirstResponder()

        }
        return true
    }
        
    override func viewWillAppear(_ animated: Bool) {
        viewAppearance.setGradientBackground(view: view)
        super.viewWillAppear(true)
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        self.animateStackViewWhenKeyboardResignsFirstResponder()
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
        
        createNewVocabWord(newVocabWord, englishTranslationText, hiraganaText, vocabText)
       
        delegate?.passDataBack(data: newVocabWord)
        
        self.dismiss(animated: true)
        //adding this dismissed the add vc from the search vc.

    }
    
    private func createNewVocabWord(_ newVocabWord: VocabInfo, _ englishTranslationText: String, _ hiraganaText: String, _ vocabText: String) {
        newVocabWord.englishTranslation = englishTranslationText
        newVocabWord.vocabHiragana = hiraganaText
        newVocabWord.vocabTitle = vocabText
        newVocabWord.numberOfTimesSeen = 0
    }

    
    @IBAction func cancelButton(_ sender: Any) {
        print(">> Cancel Button Tapped")
        
        self.dismiss(animated: true, completion: nil)

    }
    
    private func animateStackViewWhenKeyboardResignsFirstResponder() {
        UIView.animate(withDuration: 0.5) {
            self.secondaryStackViewCentreX.constant = self.secondaryStackViewCentreXConstant
            self.view.layoutIfNeeded()
            
        }
    }

}
