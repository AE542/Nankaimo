
//
//  SearchTableViewController.swift
//  ProtoKanjiAppV.3
//
//  Created by Mohammed Qureshi on 2021/06/09.
//

//2022/01/05 Attempting to add back in EditVC functionality to the search table view vc. Perhaps research how to update core data entries properly?

//2022/01/07 Wait...perhaps just a textfield when the entry is selected instead of going to the edit vc? That could update the data exactly as I want it to! AND IT DOES! Now you can do a quick edit here by selecting each tableviewCell corresponding to the saved CoreData Entry!! FINALLY!

//2022/12/21 Finally got exporting csv data into a spreadsheet working! Works really nicely with some fine tuning. Also the data can be exported easily now in case I want to export all my words in one go. Really simple solution!

import UIKit
import CoreData
import TableViewReloadAnimation
//Product -> Manage Scheme add Podfile and name of cocoapod package to the app. To solve no such module found error.

class SearchTableViewController: UITableViewController, passNewWordData {

    
    func passDataBack(data: VocabInfo) {

        saveNewItems()

        loadAddedWords()
     //}
        //self.tableView.reloadData() You dont even need to keep calling reload data just insert the data where it should go. with the .insert method. Only do this when all the data has been changed.
        self.dismiss(animated: true) {
  
        }

    }
    //Removed edit function as can't get it to update correctly in the tableview.
    //adding this back in after new commit
    
    @IBOutlet weak var wordSearchBar: UISearchBar!
    
    
    
    var vocabArray = [VocabInfo]()
    
    //let editVC = EditViewController()
    
    let mainVC = MainViewController()

    @IBOutlet weak var goToAddVCButton: UIBarButtonItem!
    
    @IBOutlet weak var createCSV: UIBarButtonItem!
    
    //let savedWordsArray = [vocabInfo.returnAllWordDataForN1().0]
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //this is how you get access to your context for Core Data.
   // let context1 = CoreDataManager.persistentContainer.viewContext
    
    
    deinit {
        print(">> SearchViewController.deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       // searchController.searchBar.barStyle = .black
        wordSearchBar.searchTextField.textColor = .white
        wordSearchBar.delegate = self //DON'T FORGET THIS!!! SEARCH BAR WON'T DO ANYTHING WITHOUT SETTING DELEGATE!
        
        let addVocabController = AddVocabularyViewController()
        addVocabController.delegate = self
        
        title = "Search Words"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        let squareImage = UIImage(systemName: "square.and.arrow.up")
        let plusImage = UIImage(systemName: "plus.app")
        
        let csv = UIBarButtonItem(image: squareImage, style: .plain, target: self, action: #selector(createArrayAsCSVSpreadsheet(_:)))
        
        let add = UIBarButtonItem(image: plusImage, style: .plain, target: self, action: #selector(goToAddWords(_:)))
        //add navigationBar Items array here and show icons at top right.
        navigationItem.rightBarButtonItems = [add, csv]
        
        loadAddedWords() // COOL! It now loads the words from the context!!!
        
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    //MARK: - CoreData Methods:
    
    func saveNewItems() {
        do {
            try context.save()
        } catch  {
            print("Error saving context: \(error)")
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }//sync it on the main thread to avoid any UI freezing.
        //self.tableView.reloadData()
    }
    
    func loadAddedWords(with request: NSFetchRequest<VocabInfo> = VocabInfo.fetchRequest()) {

        do {
          vocabArray = try context.fetch(request) //result of call fetch is unused. So we need to put it into a tableview.
        } catch  {
            print("Error loading context: \(error)")
        }

        tableView.reloadData(
            with: .simple(duration: 0.45, direction: .left(useCellsFrame: true),
            constantDelay: 0))
        //animates just as I wanted
    }
    
    func deleteSelectedWord() {
        if let indexPath = tableView.indexPathForSelectedRow{
            context.delete(vocabArray[indexPath.row])
            vocabArray.remove(at: indexPath.row)
        //vocabBuilder.vocabArray.remove(at: vocabNumber)//only updates the array
        }
    }
    
    
    @objc func goToAddWords(_ sender: Any) {
        
        performSegue(withIdentifier: "searchToAdd", sender: self)
        
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return vocabArray.count
        //return testArray.count
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        tableView.insertRows(at: [indexPath], with: .fade)
        return true
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let vocabArrayData = vocabArray[indexPath.row]
        
        
        //cell.contentView.backgroundColor =
        cell.textLabel?.text = ("\(vocabArrayData.vocabTitle), \(vocabArrayData.vocabHiragana), \(vocabArrayData.englishTranslation)")
        cell.textLabel?.textColor = UIColor.white //for the text in the label
        //only loading add word as array is empty?...perhaps have to call fetch data from context to display it here.
       

        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    } //to get the deletion option when swiping left.

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            let ac = UIAlertController(title: "Do you want to delete this word: \(vocabArray[indexPath.row].vocabTitle)?", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                self.context.delete(self.vocabArray[indexPath.row]) //ok seems to be deleting from the context here...
                
                self.vocabArray.remove(at: indexPath.row)
                //self.saveNewItems()
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                self.saveNewItems()
            }))
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(ac, animated: true) {
               
            }
            }
            
            tableView.endUpdates()
        }
    

//MARK: - Table View Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //make sure that editVC shows up
       // performSegue(withIdentifier: "goToEditViewController", sender: self)
        
//        vocabArray[indexPath.row].vocabTitle = editVC.englishTranslationData
        
        let vocab = vocabArray[indexPath.row]
        
        let ac = UIAlertController(title: "Edit Words", message: "Perform Edits Here", preferredStyle: .alert)
            
        let acs = [ac, ac, ac]
        for ac in acs {
        ac.addTextField()
        //YOU CAN DO THIS!?! It pulls up three as I needed!
        }

        let vocabTextField = ac.textFields![0]
        vocabTextField.text = vocab.vocabTitle
        //Don't put this in the submit action closure otherwise this won't show!
        let hiraganaTextField = ac.textFields![1]
        hiraganaTextField.text = vocab.vocabHiragana
        
        let englishTranslationTextField = ac.textFields![2]
        englishTranslationTextField.text = vocab.englishTranslation
        
        let updateAction = UIAlertAction(title: "Update", style: .default){
            (action) in// make a closure to handle text fields.
            
            print(">> Update")

            let vocabTextField = ac.textFields![0]
            let hiraganaTextField = ac.textFields![1]
            let englishTranslationTextField = ac.textFields![2]
            
            //edit data
            
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
            
            vocab.vocabTitle = vocabText
            
            vocab.vocabHiragana = hiraganaText
            
            vocab.englishTranslation = englishTranslationText
            
            self.saveNewItems()
            
            self.loadAddedWords()
            
//
//                self.dismiss(animated: true) {
//                    self.tableView.reloadData(with: .simple(duration: 0.45, direction: .left(useCellsFrame: true),   constantDelay: 0))
//
//            }
        
        }
        ac.addAction(updateAction)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel) {_ in
                
                print(">> Cancel Pressed")
            })
        ac.preferredAction = updateAction //cannot call function of value type, should be = wiht no brackets
        present(ac, animated: true)
        
            
        tableView.deselectRow(at: indexPath, animated: true) //this is just gonna confuse the user if you keep it in and it doesn't do anything.
         
        }

   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    if let addVocabVC = segue.destination as? AddVocabularyViewController {
           addVocabVC.delegate = self

        }
       
        }
    
    @objc func createArrayAsCSVSpreadsheet(_ sender: Any) {
       
       print("Start exporting...")
       
       let fileName = "Saved Nankaimo Words.csv"
       
       let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
       
       var csvHead = "Number,Kanji,Hiragana,English Translation, Number Of Times seen\n"
       
       var number = 0
       
        for word in vocabArray {
            number += 1
            let wordArray = [word.englishTranslation]
            let hiraganaArray = [word.vocabHiragana]
            //this could contain all the words in one line instead of seperate ones?
            //fixed the problem all on one line now even with commas they aren't separated.
            csvHead.append("\(number), \(word.vocabTitle), \(hiraganaArray), \(wordArray), \(word.numberOfTimesSeen)\n")
            
            //first main step here we need to create a directory then loop over the vocabArray with the words in it and append the csvHead to each word while adding a number to each value.
        }
           do {
               try csvHead.write(to: path!, atomically: true, encoding: .utf8)
               //atomically = Writes the contents of the String to the URL specified by url using the specified encoding.
               let exportSheet = UIActivityViewController(activityItems: [path as Any], applicationActivities: nil)
               self.present(exportSheet, animated: true, completion: nil)
               print("Exported")
           } catch {
               print("Error exporting data")
           }
       
    }
}

//MARK: - Search Bar Methods
//remember to break up parts of your code to put seperate methods where they need to be
extension SearchTableViewController: UISearchBarDelegate { //use this to get the searchbar.
   
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<VocabInfo> = VocabInfo.fetchRequest()
        //use this to make the fetch request from core data.
        //print(searchBar.text!)//prints the words entered.
        guard let searchBarText = searchBar.text else {
            return
        }
        
        request.predicate = NSPredicate(format: "(vocabTitle CONTAINS[cd] %@) || (vocabHiragana CONTAINS[cd] %@) || (englishTranslation CONTAINS[cd] %@)", searchBarText, searchBarText, searchBarText)

        request.sortDescriptors = [NSSortDescriptor(key: "vocabTitle", ascending: true), NSSortDescriptor(key: "vocabHiragana", ascending: true), NSSortDescriptor(key: "englishTranslation", ascending: true)] //must be the same string as in the predicate
        //NSSortDescriptor(key: "vocabHiragana", ascending: true), NSSortDescriptor(key: "englishTranslation", ascending: true)
        loadAddedWords(with: request)
        

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       // searchBar.barStyle = .black
        if searchBar.text?.count == 0 { //Cannot assign to property: 'count' is a get-only property should be == not =
            loadAddedWords() // calls default request to load data
            //text deletes and returns properly now.
            DispatchQueue.main.async {
                searchBar.resignFirstResponder() //to remove the keyboard from the view just like in the EditVC.
            }// update on main thread using GCD
          
        }
    }
}

