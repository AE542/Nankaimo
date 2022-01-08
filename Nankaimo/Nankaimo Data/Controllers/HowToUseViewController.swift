//
//  HowToUseViewController.swift
//  ProtoKanjiAppV.3
//
//  Created by Mohammed Qureshi on 2021/04/30.
//

import UIKit

class HowToUseViewController: UIViewController {

    @IBOutlet private(set) var closeButton: UIButton!
    @IBOutlet private(set) var howToUseText: UITextView!
    
    deinit {
        print(">> HowToUseVC.deinit")
    }
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
            
                howToUseTextAppearance.textAlignment = .center
 
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
                
                UPDATE:
                You can now add multiple hiragana if you want to learn the many ways to read one kanji.
                
                Example: For the kanji "上", it can be read as "うえ" or "じょう". If you input the hiragana for single kanji characters (for example: 上) like so:
                
                うえ、じょう、かみ
                
                it will give you correct match if you input any of the words.]
                
                English Translation: Word <- Then a translation in English (Try to keep it short to remember the Kanji and Hiragana easier.)
                
                Make sure you fill in all of the textfields!
                
                Press the Enter Button to then input the word in hiragana and try and remember the hiragana for the displayed Kanji.
                
                Press Submit to check if your word matches the hidden hiragana word. (The word will show up hidden at first like so: "???" Only when you get a match with the hiragana will it reveal itself!)
                
                You have 3 tries and if you can't remember the hiragana at all, you'll get an option to show the word after 3 attempts.
                
                Keep trying even if you make mistakes, it's all about learning the words!

                Keep an eye on your view count, remember if you've seen a word 100 times on the app, you should be able to remember it!
                
                Then cycle through to the next word using the Next Word Button.
                
                
                Editing Words:
                
                Press the Start Button, then find the word you want.
                
                Press the Edit button, then select the Edit Word button.
                
                Here you can edit an existing word, say if you make a spelling mistake, in either the Vocabulary, Hiragana, or English Translation text field.
                
                Press the Save Changes button to save your edited word.
                
                Using the Search function.
                
                First select the Search Words button on the Main Menu. You can search through all of your added words here. In the search bar you can even search in English or Japanese to find a word you have added.
                
                You can also add words from here using the Add Word button in the top right of the screen.
                
                UPDATE:
                
                You can also edit you words straight from here
                                
                Select the word:
                Example:(勉強する,　べんきょうする, To Learn)
                                
                Then you can edit the Kanji, Hiragana or English directly in the window.
                                
                Press Update to save your changes.
                                
                You can also delete words from the Search Words section, swipe left fully or swipe left and press the delete button.
                
                
                Deleting Words:
                
                If you've completely memorised a word, you can delete it if you want to.
                
                You can delete words by pressing the Word Manager Button then the Delete button, which will delete the current word.
                
                Good luck with your studying!
                
                """

            }
        
//        if let containerView = howToUseText.superview {
//            let gradient = CAGradientLayer(layer: containerView.layer)
//            gradient.frame = containerView.bounds
//            gradient.colors = [UIColor.clear.cgColor, UIColor.blue.cgColor]
//            gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
//            gradient.endPoint = CGPoint(x: 0.0, y: 0.85)
//            containerView.layer.mask = gradient
//        }
        //isn't showing up, needs to have containerView above embeded in another UIView to work?
        //was getting in the way of viewWillAppear below and overlapping with the gradients. Now looks normal.
        }
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        super.viewWillAppear(true)
    }
    
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        print(">> Close button pressed" )
        
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
