//
//  ViewController.swift
//  ProtoKanjiAppV.3
//
//  Created by Mohammed Qureshi on 2021/02/02.
//

//DO NOT CHANGE THE FILE LOCATION IN THE IDENTITY INSPECTOR.
//2021/05/07 When making a copy from the prototype app, make sure the files are connected in to the copy of the files. Also Product -> Scheme -> New Scheme to create a new file to access the simulator.
//2021/05/17 Don't forget to turn off slow animations Debug -> Slow Animations when running the simulator
//2021/05/28 Local notifications problem, its not showing no matter how many times I test it.
//2021/05/30 Local notifications showing now at the designated time, however center(request) is showing a nil error... fixed, just removed the closures, could be the string describing which created the error. Default notification made for now.
//2021/06/26 Had to fix the constraints size and width of the vocab box and the translation box because of a review saying words went off the screen. It looks better now as it confines the words to the label...but it might be better to set leading and trailing anchors so the words don't go off screen.

//2021/07/12 Adding functionality for multiple answers... it is recognising a match with the words in a sentence with no spaces but need to modify the logic to show a match if you type one of the words in a string.
//2021/07/27 FINALLY! Now you can get a match if the hiragana section contains multiple answers! splitComponents was the answer and using .joined to make the word back into a string after splitting it, was the way to get it to show up. App now allows multiple answers, but if they type one of the hiragana character that is in the string, it will get a match. This is ok because they're still learning which of the hiragana make up the kanji.
//2021/07/30 Tried to modify the submit function to avoid single letters matching. For now it's working so will release.

//2021/08/01 Ready for release build 2. Need to add permissions extensions for using tableview reload from MIT. Done with an alert controller and shipped for version 1.5

//2021/08/25 Noticed bug where show answer wasn't loading and would show a blank ac. Need to upload another update build asap.

//2021/10/15 For testing outlet connections, changed outlets from weak to private (best practice or more like convention). Changed to private(set) to  to restrict access to the outlets but still allow us to access them. Access level changes from private to internal.

//2021/12/22 ABSOLUTELY DO NOT EVER GO TO SOURCE CONTROL AND DISCARD ALL CHANGES WITHOUT MAKING A COMMIT! LOST TWO MONTHS WORTH OF TESTING CODE! DO NOT EVER DO THAT AGAIN!!!

//2021/12/23 Ok colours back. MUST DO A COMMIT TO GITHUB ASAP!

import UIKit
import CoreData

class MainViewController: UIViewController, UNUserNotificationCenterDelegate, passNewWordData, passEditedWordData {
    
    func passEditedDataBack(data: VocabInfo) {
      let currentVocabNumber = vocabNumber
        
    let newVocabNumber = 0
       
        let itemForDeletion = self.vocabBuilder.vocabArray.remove(at: currentVocabNumber)
           self.context.delete(itemForDeletion)
       
        
        self.dismiss(animated: true) {
            
            self.vocabBuilder.vocabArray.insert(data, at: self.vocabBuilder.vocabArray.startIndex)
            
            if self.vocabBuilder.vocabArray.isEmpty{
                print("Is Empty")
            } else {
            self.vocabBuilder.vocabArray.swapAt(newVocabNumber, self.vocabBuilder.vocabArray.startIndex)
            }
            self.hiraganaBox.textColor = .white
            self.saveNewWord()
            
            self.revealWord()

            self.loadNewWord()
            self.loadUI()

        }
       
    }

    func passDataBack(data: VocabInfo) {
        vocabBuilder.vocabArray.reserveCapacity(1000) //placing an upper limit here might help prevent memory reallocation...need to do more reading
        let currentVocabNumber = vocabNumber
     
        self.dismiss(animated: true) {
            //let currentVocabNumber = vocabNumber
            self.vocabBuilder.vocabArray.insert(data, at: self.vocabBuilder.vocabArray.startIndex)
            self.vocabBuilder.vocabArray.swapAt(currentVocabNumber, self.vocabBuilder.vocabArray.startIndex)
            
            self.saveNewWord()
            self.revealWord()
            self.loadUI()
            print("Current vocab no is \(vocabNumber)") //prints the position of the word in the array.
        }
    }

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//if we change the delegate for the context to TestingAppDelegate here we can run tests on this testingAppDelegate using Core Data.
    
    let editVC = EditViewController()
    
    let startMenuVC = StartViewController()

    @IBOutlet private(set) var vocabBox: UILabel!
//not key coding compliant error and kept crashing. Solved by deleting IBOutlet and recreating it
    @IBOutlet private(set) var englishTranslationBox: UILabel!
    
    @IBOutlet private(set) var hiraganaBox: UILabel!
    
    @IBOutlet private(set) var viewCount: UILabel!
    
    @IBOutlet private(set) var enterButton: UIButton!
    
    @IBOutlet private(set) var nextWordButton: UIButton!
    
    var newVocab = [VocabInfo]()
    
    var answerAttemptCount = 0
    
    var vocabBuilder = VocabBuilder()
    
    var currentVocab = String()
    var currentHiragana = String()
    var englishTranslation = String()
    //let shimmerView = BorderShimmerView()
    
    
//MARK: - Testing
    private static var allInstances = 0 //private static so its only used within the func its called and in this class
    private var instance: Int //Stored property 'instance' without initial value prevents synthesized initializers and Class has no initializers error. Usually it would need parens. But we can call an init to handle the instances instead
    //can we even call these in tests as they're private properties?

    init() {
        //self.instance = 0
        MainViewController.allInstances += 1  //adds 1 to all instances count to check the number of times the class is initialised.
         instance = MainViewController.allInstances //declare instance as a type of MyClass.allInstances
        print(">> MainViewController.init() #\(instance)") //prints when the init is called.
        //self.instance = instance
        super.init(nibName: nil, bundle: nil)
        
        
        //this fixed the 'super.init' isn't called on all paths before returning from initializer just set the nibName to nil and bundle to nil. and it can now call instances
        
        //why do we need to call super.init() though? From S.O. When you inherit a class and implement a new init function or override its own init function you should (almost) always call super.init
        
        //however this vc is initialsed 3 times according to the logs
    }

    required init?(coder aDecoder: NSCoder) {
        //self.instance = Int.init()
        //super.init
        self.instance = Int() //this fixed the property self.instance not initialised before super.init call but it's not initialising a second time... for now it works. As 0 or just an initialised Int()
      super.init(coder: aDecoder)
       // self.instance = instance
        //fatalError("init(coder:) has not been implemented")
    } //need to have this to call the init.

    deinit { //remember deinitialisers clean up code after its been initialised
        print(">> MainViewController.deinit() #\(instance)") //to check the instance number after deinit.

    }
    
        override func viewDidLoad() {
        super.viewDidLoad()
            
            title = "何回も"
            let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationController?.navigationBar.titleTextAttributes = textAttributes
            //navigationItem.leftBarButtonItem?.tintColor = .white
            navigationController?.navigationBar.tintColor = .white
            
            let addVocabController = AddVocabularyViewController()
            addVocabController.delegate = self
            
            //let shimmerView = BorderShimmerView()
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Word Manager", style: .plain, target: self, action: #selector(manageWord(_:)))
            //navigationItem.rightBarButtonItem?.tintColor = .white

            if let vocabView = vocabBox, let englishTranslationView = englishTranslationBox, let viewCountBox = viewCount, let hiraganaView = hiraganaBox {

                let views = [vocabView, viewCountBox, hiraganaView, englishTranslationView]
                
                for view in views {
                  addBorder(label: view)
                }
                
                hiraganaView.text = "???"
                hiraganaView.textColor = .white
                
               print(hiraganaView.frame.origin.x)
               print(hiraganaView.frame.origin.y)

            }

            if let nextWord = nextWordButton, let enterWord = enterButton {
               addButtonBorder(button: nextWord)
               addButtonBorder(button: enterWord)
               nextWord.startAnimatingPressActions()
               enterWord.startAnimatingPressActions()
               //wasn't animating on the first press but now it works
            }
    
            loadNewWord()
            
            loadUI()

            callNotifications() //isn't being called on my phone or watch anymore So checking if just not calling the func is the issue. Testing on the device, it now loads the permissions in the app.
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        englishTranslationBox.frame.size.width =  englishTranslationBox.intrinsicContentSize.width + 10
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        //don't forget to call viewWillAppear!
        super.viewWillAppear(true)
    }
    
    func loadUI() {

        vocabBox?.text = vocabBuilder.returnAllWordDataForN1().vocabTitle
        //vocabBox?.accessibilityLabel
        if vocabBuilder.vocabArray.isEmpty {
            hiraganaBox?.text = "Add Hiragana" //nil error if let unwrap later.
            hiraganaBox?.textColor = .white
        } else {
        hiraganaBox?.text = "???"
        }
        englishTranslationBox?.text = vocabBuilder.returnAllWordDataForN1().englishTranslation
        
        viewCount?.text = ("View Count: \(vocabBuilder.viewCount())")
        //returns the view count in a String
        
    }

    func callNotifications() {
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        center.removeAllDeliveredNotifications()

        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Granted!")
            } else {
                print("Nope not granted")
            }
        }

        let content = UNMutableNotificationContent()
            content.title = "How's your studying going?"

       // content.body = "Do you remember what \(vocabBuilder.returnAllWordDataForN1().0) is in hiragana?"

        content.body = "Have you seen any new interesting words recently? Let's review the words you've added."

        content.sound = UNNotificationSound.default

        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 30
        dateComponents.second = 00

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

       let uuidString = UUID().uuidString
       let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)

        center.add(request)
//
    }
    
    //MARK: - Border Functions
    func addButtonBorder(button: UIButton) {
        button.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).cgColor
        button.layer.borderWidth = 2.5
        button.layer.cornerRadius = 10.0
        //button.layer.addSublayer(shimmerView.layer)
        
    }
    
    func addBorder(label: UILabel) {
         label.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).cgColor
         label.layer.borderWidth = 2.5
         label.layer.cornerRadius = 10.0
         label.textAlignment = .center
         label.sizeToFit()
         //label.adjustsFontSizeToFitWidth
         label.clipsToBounds = true
        //to make sure the colour stays within the border.
     }

//MARK: - Storyboard Segue Methods
    @objc func showAddVC(action: UIAlertAction) {
        performSegue(withIdentifier: "goToAddVC", sender: self)
    }
    @objc func editCurrentWord(action: UIAlertAction) {
        performSegue(withIdentifier: "goToEditVC", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addVocabVC = segue.destination as? AddVocabularyViewController {
        addVocabVC.delegate = self
        } else if let editVC = segue.destination as? EditViewController {

            if vocabBuilder.vocabArray.isEmpty {
                
                Alert.showWarningAlertController(on: self, with: "No Words! ", message: "Please add a word by pressing the Word Manager Button")
                
            } else {
                sendVocabularyToEditVC(editVC)
            }

        editVC.delegate = self
        
        }
        
        }

//MARK: - Button Methods
    @objc func manageWord(_ sender: UIButton) {
        
        let ac = UIAlertController(title: "Add, Edit or Delete a word", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Add a New Word", style: .default, handler: (showAddVC(action:))))
        ac.addAction(UIAlertAction(title: "Edit Word", style: .default, handler: (editCurrentWord(action:))))
        ac.addAction(UIAlertAction(title: "Delete Word", style: .destructive, handler: (deleteWord(_:))))
        ac.addAction(UIAlertAction(title: "Return", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
               present(ac, animated: true)
    }
    
    @IBAction func moveToNextWord(_ sender: UIButton) {
        nextWordButton.startAnimatingPressActions()
        if vocabBuilder.vocabArray.isEmpty {
            
            Alert.showWarningAlertController(on: self, with: "You have no new words! ", message: "Please add a word by pressing the Word Manager Button")
            
        } else {
            
            showNextVocabulary()
        }
        print("CurrentVocabNumber is \(vocabNumber)")
    }
    

    @IBAction func enterHiraganaButton(_ sender: UIButton) {
        print(">> Enter Button Pressed")
        sender.startAnimatingPressActions()
        if vocabBuilder.vocabArray.isEmpty {
            
            Alert.showWarningAlertController(on: self, with: "No Words! ", message: "Please add a word by pressing the Word Manager Button")
            
        } else {
        let ac = UIAlertController(title: "What is \(vocabBuilder.returnAllWordDataForN1().vocabTitle) in Hiragana?", message: "Enter your answer into the box below", preferredStyle: .alert)
            
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default){
            [weak ac] action in// make a closure to handle text field.
            print(">> Submit")
            guard let answer = ac?.textFields?[0].text else { return }

            ac?.textFields?[0].autocorrectionType = .no
            
            self.submit(answer: answer)
        }
        ac.addAction(submitAction)
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel) {_ in 
                print(">> Cancel Pressed")
            })
        ac.preferredAction = submitAction //cannot call function of value type, should be = wiht no brackets
        present(ac, animated: true)
            
        }
    }
    
    @objc func deleteWord(_ sender: UIAlertAction) {
        if vocabBuilder.vocabArray.isEmpty {
            
            Alert.showWarningAlertController(on: self, with: "No words to delete! ", message: "Please add a word by pressing the Word Manager Button")
            
        } else { 
        
        let ac = UIAlertController(title: "Do you want to delete this word: \(vocabBuilder.returnAllWordDataForN1().0)?", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: deleteCurrentWord(_:)))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(ac, animated: true)
        }
        
    }
    
    
//MARK: - Question Logic Methods
    func submit(answer: String){
        
        let hiragana = String(vocabBuilder.returnAllWordDataForN1().hiragana)
        print("\(hiragana)")

        if vocabBuilder.vocabArray.isEmpty {
            
            Alert.showWarningAlertController(on: self, with: "No new words! ", message: "Please add a word by pressing the Word Manager Button")
            
        }
        if answerAttemptCount < 2 {
            
            let splitComponentsString = answer.components(separatedBy: " ")
            //this solution works too.
            
            print(splitComponentsString)
           // print(splitComponents)
            
            if hiragana.contains(splitComponentsString.joined()) {
                //ok adding the count to the string being more than or equal to 2 stopped just inputting one letter to get a correct answer using this //&& splitComponentsString.joined().count >= 2 {.
                //Just realised it makes it impossible to match one letter or word here as some kanji have one hiragana letter to them like 水　can be read as み

                print("Match")
                
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(systemName: "checkmark.circle.fill")?.withTintColor(.systemGreen)
            let fullString = NSMutableAttributedString(string: "Correct! ")
            fullString.append(NSAttributedString(attachment: imageAttachment))
                    let ac = UIAlertController(title: "", message: "Go to the next word!", preferredStyle: .alert)
            ac.setValue(fullString, forKey: "attributedTitle")
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: revealWord(_:)))
                        present(ac, animated: true)
            
            } else if !hiragana.contains(splitComponentsString.joined()) {
        
        Alert.showWarningAlertController(on: self, with: "Incorrect! ", message: "Try Again")
        hiraganaBox.textColor = .red
        answerAttemptCount += 1
        print("Answer Attempt count is \(answerAttemptCount)")
                print("No Match")
                
                }

        } else if hiragana != answer && answerAttemptCount == 2 {
    let ac = UIAlertController(title: "Show Answer?", message: nil, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default, handler: showHiragana(_:)))
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    present(ac, animated: true)
    answerAttemptCount = 0
}
        
}
        
    func revealWord(_ sender: UIAlertAction){
        hiraganaBox?.text = vocabBuilder.returnAllWordDataForN1().hiragana
            hiraganaBox?.textColor = .green
            hiraganaBox?.revealTransition(0.5)
    }
    
    func showHiragana(_ sender: UIAlertAction) {
        hiraganaBox.text = vocabBuilder.returnAllWordDataForN1().hiragana
        hiraganaBox.textColor = .red
        hiraganaBox.revealTransition(0.5)
    
    }
    
//MARK: - Core Data Save/Load/Delete Methods
    func saveNewWord() {
        do {
            try context.save()
      
        } catch  {
            print("Error saving context: \(error)")
        }
    }
    
    func loadNewWord(){
        let request: NSFetchRequest<VocabInfo> = VocabInfo.fetchRequest()
        do {
            vocabBuilder.vocabArray = try context.fetch(request)
            
        } catch  {
            print("Error fetching data from context: \(error)")
        }
    }
    
    func deleteCurrentWord(_: UIAlertAction) {
        context.delete(vocabBuilder.vocabArray[vocabNumber])
        vocabBuilder.vocabArray.remove(at: vocabNumber)//only updates the array
        saveNewWord()
        vocabBuilder.nextVocab()
        revealWord()
        loadUI()
    }

    func revealWord() {
        vocabBox.pushTransition(0.5)
        hiraganaBox.pushTransition(0.5)
        englishTranslationBox.pushTransition(0.5)
        viewCount.pushTransition(0.5)
        
    }
    
    private func sendVocabularyToEditVC(_ editVC: EditViewController) {
         editVC.vocabData = vocabBuilder.vocabArray[vocabNumber].vocabTitle
         editVC.hiraganaData = vocabBuilder.vocabArray[vocabNumber].vocabHiragana
         editVC.englishTranslationData = vocabBuilder.vocabArray[vocabNumber].englishTranslation
     }
    
    private func showNextVocabulary() {
        vocabBuilder.nextVocab()
        vocabBox.pushTransition(0.2)
        hiraganaBox.textColor = .white
        answerAttemptCount = 0
        loadUI()
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

//MARK: - UIView Transition Methods
extension UIView {
    
    func pushTransition(_ duration: CFTimeInterval) {
        let animation = CATransition()
        
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
  
        animation.type = CATransitionType.push
        
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.push.rawValue)
    }
// Now the views transition with a fade in using this ext!!

    func revealTransition(_ duration: CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        animation.type = CATransitionType.reveal
        
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.reveal.rawValue)
    }
    
}

extension UIButton {
    //do reading on this properly.
    func startAnimatingPressActions() {
        addTarget(self, action: #selector(animateDown), for: [.touchDown])
        //addTarget: Associates a target object and action method with the control.
        addTarget(self, action: #selector(animateUp), for: [.touchUpInside, .touchUpOutside])
    }
    
    @objc private func animateUp(sender: UIButton) {
        animate(sender, transform: CGAffineTransform.identity.scaledBy(x: 0.98, y:0.98))
    }
    
    @objc private func animateDown(sender: UIButton) {
        animate(sender, transform: CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1))
    }
    
    private func animate(_ button: UIButton, transform: CGAffineTransform) {
    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: { //
        button.transform = transform
    }, completion: nil)
}
    
}

