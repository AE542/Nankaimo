//
//  EditViewController.swift
//  ProtoKanjiAppV.3
//
//  Created by Mohammed Qureshi on 2021/05/03.
//

import UIKit
import CoreData

protocol passEditedWordData: AnyObject {

    func passEditedDataBack(data: VocabInfo)

}

let vocabInfo = VocabBuilder()

class EditViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var editVocabTextField: UITextField!
    
    @IBOutlet weak var editHiraganaTextField: UITextField!
    
    @IBOutlet weak var editEnglishTranslationTextField: UITextField!
    
    @IBOutlet weak var saveChangesButtonLabel: UIButton!
    
    @IBOutlet weak var cancelChangesButton: UIButton!
    
    //@IBOutlet weak var editStackView: UIStackView!
    
    @IBOutlet weak var editStackViewCentreYConstraint: NSLayoutConstraint!
    var editStackViewYConstant: CGFloat = 0
    @IBOutlet weak var editStackViewCentreXConstraint: NSLayoutConstraint!
    var editStackViewXConstant: CGFloat = 0

    
    var vocabData = ""
    var hiraganaData = ""
    var englishTranslationData = ""
    // having empty strings here to handle the data passed from the main vc here is essential to putting the value inside the text fields.
    
    weak var delegate: passEditedWordData?
    
    //@IBOutlet weak var editVocabLabel: UILabel!
    
//    let mainVC = MainViewController()
   // Thread 1: EXC_BAD_ACCESS (code=2, address=0x7ffee35f9ff8)
    //DON'T CALL THIS IN THE VC!! An instance of main VC has already been declared so it creates an infinite loop of initialisation and crashes the app. This was already declared in the addVocabularyVC.
    
    override func viewDidLoad() {
       super.viewDidLoad()

        if let saveChanges = saveChangesButtonLabel {
            mainVC.addButtonBorder(button: saveChanges)
        }
        
        if let cancelButton = cancelChangesButton {
            mainVC.addButtonBorder(button: cancelButton)
        }

        loadEditData() //data is being passed, but to the wrong textfield....needs sorting out again.
        //Fixed, now data is going to the correct textfields.
        
        editVocabTextField.delegate = self
        editHiraganaTextField.delegate = self
        editEnglishTranslationTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }


     func loadEditData() {
        editVocabTextField.text = vocabData
        editHiraganaTextField.text = hiraganaData
        editEnglishTranslationTextField.text = englishTranslationData
        //might need to wrap these in guard lets like in the addvocabVC.
        
    }

    
    @IBAction func saveChangesButton(_ sender: Any) {
        
        let ac = UIAlertController(title: "Save Changes?", message: "This will update the current word.", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: editConfirm(sender:)))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
present(ac, animated: true)

//editConfirm code used to be here, but to get alert to show properly, needed it's seperate func.
        
    }
    
    func editConfirm(sender: UIAlertAction) {

        guard let editVocabText = editVocabTextField.text, editVocabTextField.hasText else {
            print("Error no data")

            Alert.showWarningAlertController(on: self, with: "Missing Vocabulary Word! ", message: "Please fill in the Vocabulary field")
            
            return
        }
        
        guard let editHiraganaText = editHiraganaTextField.text, editHiraganaTextField.hasText else {
            
            Alert.showWarningAlertController(on: self, with: "Missing hiragana! ", message: "Please fill in the Hiragana field")
            return
            
        }
        guard let editEnglishTranslationText = editEnglishTranslationTextField.text, editEnglishTranslationTextField.hasText else {
        
            print("Error no english translation entered.")
            
            Alert.showWarningAlertController(on: self, with: "Missing English Translation! ", message: "Please fill in the English Translation field")
            
            return
        }
        
        let updatedVocabWord = VocabInfo(context: mainVC.context)
                updatedVocabWord.vocabTitle = editVocabText
                updatedVocabWord.vocabHiragana = editHiraganaText
                updatedVocabWord.englishTranslation = editEnglishTranslationText
        
        
        delegate?.passEditedDataBack(data: updatedVocabWord)
        
        //We're just using the same methods to pass the data back as in the AddVocabulary ViewController.
    }

    @IBAction func cancelChangesButton(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        editVocabTextField.resignFirstResponder()
        editHiraganaTextField.resignFirstResponder()
        editEnglishTranslationTextField.resignFirstResponder()
        //resignFirstResponder is for when the textfield has finished being used and can then be dismissed.
        
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5) {
            
            //self.editStackViewCentreYConstraint.constant = self.editStackViewYConstant
            
            self.editStackViewCentreXConstraint.constant = self.editStackViewXConstant
            
            self.view.layoutIfNeeded()
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        editVocabTextField.resignFirstResponder()
        editHiraganaTextField.resignFirstResponder()
        editEnglishTranslationTextField.resignFirstResponder()

        self.view.layoutIfNeeded()

        UIView.animate(withDuration: 0.5) {
            self.editStackViewCentreXConstraint.constant = self.editStackViewXConstant
            self.view.layoutIfNeeded()
            
        }
    }
    
    
    @objc func keyboardWillShowNotification(notification: NSNotification) {
        if let info = notification.userInfo {

        let rect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect // height of the keyboard
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.25) {
          
            self.editStackViewCentreXConstraint.constant = rect.height - 425
            
            self.view.layoutIfNeeded()
        }
    }
    
    }

}

