//
//  HowToUseViewController.swift
//  ProtoKanjiAppV.3
//
//  Created by Mohammed Qureshi on 2021/04/30.
//

import UIKit
import AVKit
import AVFoundation


class HowToUseViewController: UIViewController {
    
    //let demoVideo = DemoVideo()

    @IBOutlet private(set) var closeButton: UIButton!
    @IBOutlet private(set) var howToUseText: UITextView!
    
    @IBOutlet weak var demoVideoButton: UIButton!
    
    deinit {
        print(">> HowToUseVC.deinit")
    }
    
    let viewAppearance = BackgroundColor()
    override func viewDidLoad() {
        super.viewDidLoad()
        

        if let closeButtonAppearance = closeButton {
            mainVC.addButtonBorder(button: closeButtonAppearance)
        }
        
        if let demoVideoButtonAppearance = demoVideoButton {
            
            demoVideoButtonAppearance.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).cgColor
            demoVideoButtonAppearance.layer.borderWidth = 2.5
            demoVideoButtonAppearance.layer.cornerRadius = 10.0
        
            demoVideoButtonAppearance.titleLabel?.textAlignment = .center
//            demoVideoButtonAppearance.font.withSize(20.0)
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
                
                To see a quick demonstration of the app in action, please press the demo button below to view how to use this app.
                
                Adding a word:
                
                You can add words directly from the main menu by selecting the Add A Word button.
                
                You can also add your own words by pressing the Word Manager button in the top right of the screen after pressing the Start button.
                
                Try to add you own words like so:
                
                Vocabulary: 言葉 <- Write the word in Kanji first
                
                Hiragana: ことば <- Then the same word in hiragana (If using the Kana keyboard, press Enter (確定) twice in the bottom right corner of the keyboard, to enter Hiragana)
                
                UPDATE:
                You can now add multiple hiragana if you want to learn the many ways to read one kanji.
                
                Example: For the kanji "上", it can be read as "うえ" or "じょう". If you input the hiragana for single kanji characters (for example: 上) like so:
                
                うえ、じょう、かみ
                
                it will give you correct match if you input any of the hiragana.
                
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
                
                You can also add words from here by pressing the + button in the top right of the screen.
                
                UPDATE:
                
                You can now export all your words to a CSV file. You can then open this file in a spreadsheet either in Numbers for Mac or Excel.
                
                Press the share button (square with the arrow pointing up), select save your files, and save it on your device or iCloud.
                
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
        
        }
    
    override func viewWillAppear(_ animated: Bool) {
        viewAppearance.setGradientBackground(view: view)
        super.viewWillAppear(true)
    }
    
    @IBAction func showDemoVideo(_ sender: UIButton) {
        
//       let url = URL(fileURLWithPath: Bundle.main.path(forResource: "demo", ofType: "mp4")!)
//
//                 //create an instance of AVPlayer passing it the HTTP URL
//         let player = AVPlayer(url: url)
//        //ADD THE VIDEO TO TARGETS OTHERWISE IT WILL KEEP COMING BACK AS NIL AND CRASHING
//
//         let layer = AVPlayerLayer(player: player)
//
//         layer.frame = view.bounds
//         view.layer.addSublayer(layer)
//
//         player.play()
        
        //demoVideo.playDemoVideo()
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        print(">> Close button pressed" )
        
        self.dismiss(animated: true, completion: nil)
    }

}
