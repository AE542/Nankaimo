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

import UIKit
import CoreData

class MainViewController: UIViewController, UNUserNotificationCenterDelegate, passNewWordData, passEditedWordData {
    
    func passEditedDataBack(data: VocabInfo) {
      let currentVocabNumber = vocabNumber
        
      let newVocabNumber = 1
       
        let itemForDeletion = self.vocabBuilder.vocabArray.remove(at: currentVocabNumber)
           self.context.delete(itemForDeletion)
       
        
        self.dismiss(animated: true) {
            
//         let itemForDeletion = self.vocabBuilder.vocabArray.remove(at: currentVocabNumber)
//            self.context.delete(itemForDeletion)
//
            //let newVocabNo = vocabNumber
//            self.editVC.editEnglishTranslationTextField?.text = data.englishTranslation
//            self.editVC.editVocabTextField?.text = data.vocabTitle
//            self.editVC.editHiraganaTextField?.text = data.vocabHiragana
//
//            self.vocabBuilder.vocabArray[currentVocabNumber].setValue(data.vocabTitle, forKey: "vocabTitle")
//            self.vocabBuilder.vocabArray[currentVocabNumber].setValue(data.vocabHiragana, forKey: "vocabHiragana")
//            self.vocabBuilder.vocabArray[currentVocabNumber].setValue(data.englishTranslation, forKey: "englishTranslation")
            
            self.vocabBuilder.vocabArray.insert(data, at: self.vocabBuilder.vocabArray.startIndex)
            
            self.vocabBuilder.vocabArray.swapAt(newVocabNumber, self.vocabBuilder.vocabArray.startIndex)
            
            self.hiraganaBox.textColor = .white
            self.saveNewWord()
            
            self.revealWord()

            self.loadNewWord()
            
            //self.loadUI() //this loads the next word but at random like its meant to...
            
             //self.loadUpdatedWord()
            
//            func returnEditedWord() -> Int {
//                self.vocabBox.text = self.vocabBuilder.returnAllWordDataForN1().vocabTitle
//                self.hiraganaBox.text = self.vocabBuilder.returnAllWordDataForN1().hiragana
//
//                return currentVocabNumber
//            }
            
            //self.returnEditedWord()
            //problem where edited word in text field is just being loaded again and again... It has something to do with the way the data is being passed.
            //SOLVED: Should have been passing back the text from the textfield not just the item itself...now it's deleting the item, replacing with changes and saving them but not immediately showing the new word.
        }
       
    }
    
    
    func passDataBack(data: VocabInfo) {
        vocabBuilder.vocabArray.reserveCapacity(1000) //placing an upper limit here might help prevent memory reallocation...need to do more reading
        let currentVocabNumber = vocabNumber
     
        self.dismiss(animated: true) {
            //let currentVocabNumber = vocabNumber
            self.vocabBuilder.vocabArray.insert(data, at: self.vocabBuilder.vocabArray.startIndex)
            self.vocabBuilder.vocabArray.swapAt(currentVocabNumber, self.vocabBuilder.vocabArray.startIndex)
           
            //this is really working!!! It swaps the current index of the vocab number with the start and loads the view again.
            
            self.saveNewWord()
            self.revealWord()
            self.loadUI()
            print("Current vocab no is \(vocabNumber)") //prints the position of the word in the array.
        }
    }

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //for Core Data we can create a context in which our data passes through. It's like a staging ground for the data before it can be CRUD.
    
    //let addVC = AddVocabularyViewController()r
       // Thread 1: EXC_BAD_ACCESS (code=2, address=0x7ffee35f9ff8)
        //DON'T CALL THIS IN THE VC!! An instnce of main VC has already been declared so it creates an infinite loop of initialisation and crashes the app. This was already declared in the addVC view controller
    
    let editVC = EditViewController()

    @IBOutlet weak var vocabBox: UILabel!
//not key coding compliant error and kept crashing. Solved by deleting IBOutlet and recreating it
    @IBOutlet weak var englishTranslationBox: UILabel!
    
    @IBOutlet weak var hiraganaBox: UILabel!
    
    @IBOutlet weak var viewCount: UILabel!
    
    @IBOutlet weak var enterButton: UIButton!
    
    @IBOutlet weak var nextWordButton: UIButton!
    
    var newVocab = [VocabInfo]()
    
    var answerAttemptCount = 0
    
    var vocabBuilder = VocabBuilder()
    //changed from vocabInfo to make it more clear where the data is coming from.
    
    var currentVocab = String()
    var currentHiragana = String()
    var englishTranslation = String()
//for passing the data to the the EditViewController.
    
        override func viewDidLoad() {
        super.viewDidLoad()

            title = "何回も"
            let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationController?.navigationBar.titleTextAttributes = textAttributes
            
            //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)) To help find the location of the data model. Was able to check this using an SQLite Database reader to see if the Vocab items were being saved.
            
            let addVocabController = AddVocabularyViewController()
            addVocabController.delegate = self
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Word Manager", style: .plain, target: self, action: #selector(manageWord(_:)))

            if let vocabView = vocabBox, let englishTranslationView = englishTranslationBox, let viewCountBox = viewCount, let hiraganaView = hiraganaBox {
                addBorder(label: vocabView)
                addBorder(label: englishTranslationView)
                addBorder(label: viewCountBox)
                addBorder(label: hiraganaView)
                hiraganaView.text = "???"
                hiraganaView.textColor = .white
//                UIFont(name: "DIN-Alternate", size: 20.0)
//                UIFont.Weight(2.0)
            }

            if let nextWord = nextWordButton, let enterWord = enterButton {
               addButtonBorder(button: nextWord)
               addButtonBorder(button: enterWord)
            }
    
            loadNewWord() //success! Words are now loading
            
            loadUI()
            //to reload the data from the VocabManager in the Model.
    }
    
    func loadUI() {
        //changed returnvalues from numbered (.0) to the parameter name for clarity's sake.
        
        vocabBox?.text = vocabBuilder.returnAllWordDataForN1().vocabTitle // changed from .0 as its more clear what exactly is being returned from the VocabManager
        
        //vocabBox.fadeTransition(0.2) //need to add extension for transitions, however it was better to move this to a function as it's going to be called multiple times.
        
        if vocabBuilder.vocabArray.isEmpty {
            hiraganaBox.text = "Add Hiragana"
            hiraganaBox.textColor = .white
        } else {
        hiraganaBox?.text = "???"
        }
        englishTranslationBox?.text = vocabBuilder.returnAllWordDataForN1().englishTranslation
        
        viewCount?.text = ("View Count: \(vocabBuilder.viewCount())")
        //returns the view count in a String
        

    }


    func callNotifications() {
        
        //UNUserNotificationCenter ask for permission from the user.
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        center.removeAllDeliveredNotifications()
        //these two are useful for testing, however it also keeps removing the same notification from repeating over and over.
        
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Granted!")
            } else {
                print("Nope not granted")
            }
        } //permission allowed so will trigger when the app opens. //needs refactoring
        
        //create notification content
       
        let content = UNMutableNotificationContent() //need this class to create the content.
        
//        if vocabBuilder.vocabArray.isEmpty == true {
//        content.title = "How's your studying going?"
//        content.body = "Add your first word!"
//        content.sound = UNNotificationSound.default
//        } else {
            content.title = "How's your studying going?"
        //content.subtitle = "Try and add some new words!"
        content.body = "Seen any interesting Kanji? Try and add some new words here!"
        //content.body = "Do you remember what \(vocabBuilder.vocabArray[vocabNumber].vocabTitle) is in hiragana?"
        //Keeps returning as if vocabBuilder.vocabArray is empty but its not.... so changing to default message for now.
            content.sound = UNNotificationSound.default
        //}
        //crude solution but it should show a different content title here...
        
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 30
        dateComponents.second = 00
        
        
        //do not call the vocab number it will crash the app
        //when should this notification show?
     // let date = Date().addingTimeInterval(10) //10 second timer, is working because the date components before didn't have the .second added so it wouldn't trigger
        //NEED TO TRIGGER EVERYDAY at 10:30 + must be random words
// CLEAN BUILD FOLDER EACH TIME TO TEST
        
        //let date = Date()
        //let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
    
       // let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
//        var dateComponents = DateComponents()
//        //var dateComponents1 = Calendar.current.date
//        //dateComponents.day = 4
//        dateComponents.hour = 11
//        dateComponents.minute = 44
        //not triggering more difficult to test
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        //has to be more than 60 seconds when testing so set to false to just test if it comes up
        
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false) this is good for testing.
        
        
        //need to create request to put all the objects into one place
        let uuidString = UUID().uuidString
       let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
         //register request with notification center.
        
        center.add(request)
        //for some reason adding a closure to check for errors produced an error which wouldn't load the words.
        //{
        //error in
//            //check error param and handle errors
//            print("Error: Notification not added: \(String(describing: error))")
//        }
        //center.removeAllPendingNotificationRequests()
        //center.removeAllDeliveredNotifications()
    }
    
    
    
    //MARK: - Border Functions
    func addButtonBorder(button: UIButton) {
        button.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).cgColor
        button.layer.borderWidth = 2.5
        button.layer.cornerRadius = 10.0
        
    }
    
    func addBorder(label: UILabel) {
         label.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).cgColor
         label.layer.borderWidth = 2.5
         label.layer.cornerRadius = 10.0
         label.textAlignment = .center
         label.sizeToFit()
     }
//moving the border functions outside of viewDidLoad() allows them to be accessed in other ViewControllers.
    
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
            editVC.vocabData = vocabBuilder.vocabArray[vocabNumber].vocabTitle
            editVC.hiraganaData = vocabBuilder.vocabArray[vocabNumber].vocabHiragana
            editVC.englishTranslationData = vocabBuilder.vocabArray[vocabNumber].englishTranslation
            }

        editVC.delegate = self
        
        }// needs refactoring to add the storyboard ids.
        
        //adding the delegate here made this work!! Now words can be added to the main array.
        }
//    override func performSegue(withIdentifier identifier: String, sender: Any?) {
//        <#code#>
//    }

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
        
        if vocabBuilder.vocabArray.isEmpty {
            
            Alert.showWarningAlertController(on: self, with: "You have no new words! ", message: "Please add a word by pressing the Word Manager Button")
            
        } else {

        vocabBuilder.nextVocab()
        vocabBox.pushTransition(0.2)
        hiraganaBox.textColor = .white
        answerAttemptCount = 0
        loadUI()
        }
        print("CurrentVocabNumber is \(vocabNumber)")
    }
    

    @IBAction func enterHiraganaButton(_ sender: UIButton) {
        if vocabBuilder.vocabArray.isEmpty {
            
            Alert.showWarningAlertController(on: self, with: "No Words! ", message: "Please add a word by pressing the Word Manager Button")
            
        } else {
        let ac = UIAlertController(title: "What is \(vocabBuilder.returnAllWordDataForN1().vocabTitle) in Hiragana?", message: "Enter your answer into the box below", preferredStyle: .alert)
            
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default){
            [weak ac] action in// make a closure to handle text field.
            
            //a weak ac here means that its retain cycle is weak and memory can be allocated to other processes. It's usually better to use weak self here to avoid retain cycles when using "strong".
            guard let answer = ac?.textFields?[0].text else { return }
            //conditions are correct with guard let now it can run and bail if something goes wrong.
            ac?.textFields?[0].autocorrectionType = .no
            
            self.submit(answer: answer)//Cannot use optional chaining on non-optional value of type 'ViewController' error
            //OK! changing it to self.submit (answer: answer) made it correct!!!
            // attempt to get inputs to match text
        }
        ac.addAction(submitAction)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
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
    func submit(answer: String) {
        if vocabBuilder.vocabArray.isEmpty {
            
            Alert.showWarningAlertController(on: self, with: "No new words! ", message: "Please add a word by pressing the Word Manager Button")
            //we're calling self to call the MainVC
            
        } else if answerAttemptCount < 2 {
        if vocabBuilder.returnAllWordDataForN1().hiragana == answer {
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(systemName: "checkmark.circle.fill")?.withTintColor(.systemGreen)
            let fullString = NSMutableAttributedString(string: "Correct! ")
            fullString.append(NSAttributedString(attachment: imageAttachment))
                    let ac = UIAlertController(title: "", message: "Go to the next word!", preferredStyle: .alert)
            ac.setValue(fullString, forKey: "attributedTitle")
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: revealWord(_:)))
                        present(ac, animated: true)


    } else if vocabBuilder.returnAllWordDataForN1().hiragana != answer {
        
        Alert.showWarningAlertController(on: self, with: "Incorrect! ", message: "Try Again")
        hiraganaBox.textColor = .red
        answerAttemptCount += 1
        print("Answer Attempt count is \(answerAttemptCount)")
    }

} else if vocabBuilder.returnAllWordDataForN1().hiragana != answer || answerAttemptCount == 2 {
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
            //saves data to the NSPersistent container in the AppDelegate.
        } catch  {
            print("Error saving context: \(error)")
        }
    }
    
    func loadNewWord(){
        let request: NSFetchRequest<VocabInfo> = VocabInfo.fetchRequest()
        do {
            vocabBuilder.vocabArray = try context.fetch(request) //this pulls back all the data from the SQLite database. Remember it goes through the context then it's added to the app.
            //fetch returns an array of NSFetchRequest Items aka the VocabInfo array
        } catch  {
            print("Error fetching data from context: \(error)")
        }
    }
    
    func deleteCurrentWord(_: UIAlertAction) {
        
        context.delete(vocabBuilder.vocabArray[vocabNumber])
        vocabBuilder.vocabArray.remove(at: vocabNumber)//only updates the array
        
                   saveNewWord()
                   vocabBuilder.nextVocab()//....calling next vocab here has solved the index out of range error? So it functions like the next word button and moves to the next word before loading the ui.
        //vocabBuilder.showEditedVocab()
        revealWord()
        
       loadUI()

    }
        //this is how we actually delete the data however we need to make sure the data is deleted so we need to save it in its current state.
        //has to be of type NSManaged Object so MUST include vocabBuilder.

    func revealWord() {
        vocabBox.pushTransition(0.5)
        hiraganaBox.pushTransition(0.5)
        englishTranslationBox.pushTransition(0.5)
        viewCount.pushTransition(0.5)
        //could make the param of type CFTimeInterval instead.
    }
}

//MARK: - UIView Transition Methods
extension UIView {
    
    func pushTransition(_ duration: CFTimeInterval) {// needs param to handle duration CFTimeInterval represents time in seconds.
        let animation = CATransition()// saw this before in searching for how to use Core Animation to fade in words.
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        //timingFunc defines the pace, CAMediaTimingFunc is a class that defines the pacing of an animation as a timing curve
        animation.type = CATransitionType.push
        //so CATransitionType has a lot of ways to transition after it using dot notation. .fade allows it to fade words in. .reveal, slides the UILabel out like a card. currently .push allows the card to come in from the left and leave the screen on the right.
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.push.rawValue)
    }
// Now the views transition with a fade in using this ext!!

    func revealTransition(_ duration: CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.reveal
     //.reveal, slides the UILabel out like a card. currently .push allows the card to come in from the left and leave the screen on the right.
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.reveal.rawValue)
    }

}

