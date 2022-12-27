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

protocol passSearchViewEditedWordData: AnyObject {
    func passUpdatedEditedWordBack(data: VocabInfo)
}

let vocabInfo = VocabBuilder()

class EditViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var editVocabTextField: UITextField!
    
    @IBOutlet weak var editHiraganaTextField: UITextField!
    
    @IBOutlet weak var editEnglishTranslationTextField: UITextField!
    
    @IBOutlet private(set) var saveChangesButton: UIButton!
    
    @IBOutlet private(set) var cancelChangesButton: UIButton!
    
    //@IBOutlet weak var editStackView: UIStackView!
    
    @IBOutlet weak var editStackViewCentreYConstraint: NSLayoutConstraint!
    var editStackViewYConstant: CGFloat = 0
    @IBOutlet weak var editStackViewCentreXConstraint: NSLayoutConstraint!
    var editStackViewXConstant: CGFloat = 0

    
    var vocabData = ""
    var hiraganaData = ""
    var englishTranslationData = ""
    
    let viewAppearance = BackgroundColor()
    
    weak var delegate: passEditedWordData?
    
    weak var searchEditDelegate: passSearchViewEditedWordData?
    
    override func viewDidLoad() {
       super.viewDidLoad()

        if let saveChanges = saveChangesButton {
            mainVC.addButtonBorder(button: saveChanges)
        }
        
        if let cancelButton = cancelChangesButton {
            mainVC.addButtonBorder(button: cancelButton)
        }

        loadEditData()
        
        viewAppearance.setGradientBackground(view: view)
        
        //err....why weren't these values unwrapped?
        
        if let editedVocabText = editVocabTextField, let editedHiraganaTextField = editHiraganaTextField, let editedEnglishTranslationTextField = editEnglishTranslationTextField {
        editedVocabText.delegate = self
        editedHiraganaTextField.delegate = self
        editedEnglishTranslationTextField.delegate = self
        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(true)
    }

     func loadEditData() {
        editVocabTextField.text = vocabData  //caused crash on Unit Test to check for data because no data in the field.
        editHiraganaTextField.text = hiraganaData
        editEnglishTranslationTextField.text = englishTranslationData
        //might need to wrap these in guard lets like in the addvocabVC.
        //just needed sut.loadViewIfNeeded in the tests to make sure it was running correctly.
        
    }

    
    @IBAction func saveChanges(_ sender: Any) {
        
        print(">> Save Changes Button tapped")
        
        let ac = UIAlertController(title: "Save Changes?", message: "This will update the current word.", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: editConfirm(sender:)))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
present(ac, animated: true)

        
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
        updateWordData(updatedVocabWord, editVocabText, editHiraganaText, editEnglishTranslationText)
        
        delegate?.passEditedDataBack(data: updatedVocabWord)
        
        searchEditDelegate?.passUpdatedEditedWordBack(data: updatedVocabWord)
        
    }
    
    private func updateWordData(_ updatedVocabWord: VocabInfo, _ editVocabText: String, _ editHiraganaText: String, _ editEnglishTranslationText: String) {
        updatedVocabWord.vocabTitle = editVocabText
        updatedVocabWord.vocabHiragana = editHiraganaText
        updatedVocabWord.englishTranslation = editEnglishTranslationText
    }

    @IBAction func cancelChangesButton(_ sender: Any) {
        print(">> Cancel Button Tapped")
        self.dismiss(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === editVocabTextField {
            //remember === makes sure that the textfield is the one thats being used
            editHiraganaTextField.becomeFirstResponder()
        } else if textField === editHiraganaTextField {
            editEnglishTranslationTextField.becomeFirstResponder()
        } else if textField === editEnglishTranslationTextField {
            editEnglishTranslationTextField.resignFirstResponder()
            
        
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5) {
            
            self.editStackViewCentreXConstraint.constant = self.editStackViewXConstant
            
            self.view.layoutIfNeeded()
        }
        
    }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)

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

