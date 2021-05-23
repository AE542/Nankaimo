//
//  HowToUseViewController.swift
//  ProtoKanjiAppV.3
//
//  Created by Mohammed Qureshi on 2021/04/30.
//

import UIKit

class HowToUseViewController: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var howToUseText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let closeButtonAppearance = closeButton {
            mainVC.addButtonBorder(button: closeButtonAppearance)
        }
            if let howToUseTextAppearance = howToUseText {
                howToUseTextAppearance.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).cgColor
                howToUseTextAppearance.layer.borderWidth = 2.5
                howToUseTextAppearance.layer.cornerRadius = 10.0
                howToUseTextAppearance.textColor = .white
                
                howToUseTextAppearance.text = """
                
                Welcome to Nankaimo!
                
                The idea of this App is to create your own flashcards for you to memorise from with the number of times you've seen a word in Japanese.
                
                Before you start, make sure you have your keyboard set to Japanese Kana or Romaji to use it the way you want.
                (Settings -> General -> Keyboard -> Keyboard -> Add a New Keyboard)

                
                Adding a word:
                
                You can add your own words by pressing the Word Manager button in the top right of the screen.
                
                Try to add you own words like so:
                
                Vocabulary: 言葉 <- Write the word in Kanji first
                
                Hiragana: ことば <- Then the same word in hiragana (If using the Kana keyboard, press Enter (確定) twice in the bottom right corner of the keyboard, to enter Hiragana)
                
                English Translation: Word <- Then a translation in English (Try to keep it short to it remember easier.)
                
                Make sure you fill in all of the textfields!
                
                Press the Enter Button to then input the word in hiragana and try and remember the hiragana for the displayed Kanji.
                
                Press Submit to check if your word matches the hidden hiragana word. (The word will show up hidden at first like so: "???" Only when you get a match with the hiragana will it reveal itself!)
                
                You have 3 tries and if you can't remember the hiragana at all, you'll get an option to show the word after 3 attempts.
                
                Keep trying even if you make mistakes, it's all about learning the words!

                Keep an eye on your view count, remember if you've seen a word 100 times on the app, you should be able to remember it!
                
                Then cycle through to the next word using the Next Word Button.
                
                
                Editing Words:
                
                Press the Edit button, then select the Edit Word button.
                
                Here you can edit an existing word, say if you make a spelling mistake, in either the Vocabulary, Hiragana, or English Translation text field.
                
                Press the Save Changes button to save your edited word.
                
                
                Deleting Words:
                
                If you've completely memorised the word, you can delete it if you want to.
                
                You can delete words by pressing the Word Manager Button then the Delete button, which will delete the current word.
                
                Good luck with your studying!
                
                """
                //need to implement scroll view and change font size.
                //DONE, already has scrolling implemented in the text view itself, user interaction should be disabled.
            }
        }
    
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
