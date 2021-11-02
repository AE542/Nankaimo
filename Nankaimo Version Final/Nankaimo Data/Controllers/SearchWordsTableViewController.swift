
//
//  SearchTableViewController.swift
//  ProtoKanjiAppV.3
//
//  Created by Mohammed Qureshi on 2021/06/09.
//

//2021/05/24 Need to get current CoreData attributes showing up in the tableview. Perhaps move the search to the main view? Need to add search bar at the top of the view...
//2021/05/30 Need to get core data objects to show up here as a list...but vocabArray is still showing up as 0.
//2021/05/31 Going to create a new fetch data function to get the data and list it here so its not just relying on the vocabManager to get the data. OK! It's working!! Don't think I need the save context method...but the load method is doing exactly what I wanted, loading the VocabInfo items from the context and loading them as a list. to view.
//2021/06/03 Search bar is working just there's a problem loading the edit vc when an indexPath.row is selected. Now need to incorporate Cocoapods to the app to get the tableview to load with animations.
//2021/06/04 Success with cocoapods! TableView now animates really nicely. Before submitting version 2.0 just make sure you have include the credited with MIT for using the pod. Still have the problem with loading data depending on which cell was selected.
//2021/06/07 OK today attempt to change colour of tableview background colour and text colour. Also look into getting data to show in edit vc. Done...took longer than it should have. Just needed to refer to the searchbar as an outlet and change the text colour to white and t pod 'TableViewReloadAnimation', '~> 0.0'he background was set in the I.B. to turn it the same colour scheme as the app. Seperators changed to white so its clear what's showing up. UPDATE: Now it's working! selecting any cell loads the context from the Core Data Model! Just needed an if let statement with tableView.indexPathForSelectedRow method to get the data showing in the editVC! Next problem: how to delete data from the context and reload the table view so its been completely replaced like in the original edit vc.

//Reminder once again DO NOT CHANGE THE LOCATION OF THE FILE IN IDENTITY INSPECTOR! It's very difficult to get the program to work again if its changed to a folder.

//2021/06/10  changed deletion method as just swiping to delete all your words is too immediate with no warning, so added it to the completion handler for the delete button to remove it. Still need to update words when edited... UPDATE: Words are deleting without index out of range errors but its not deleting the original word from the context. Original word being deleted but not replacing the old word...

//2021/06/15 Can't replace the old word without causing an index out of range error again...Need to try and update the value seperately.
//2021/07/15 Able to delete the first word in the tableview with the itemForDeletion method, but not the selected tableViewCell. Might add the add word function back here.
//2021/07/23 Added add word button back so can add words from the search table view. Needed to add the self.dismiss method to the edit vc to get this to dismiss when accessing the addVC from the tableview.

import UIKit
import CoreData
import TableViewReloadAnimation
//Product -> Manage Scheme add Podfile and name of cocoapod package to the app. To solve no such module found error.

class SearchTableViewController: UITableViewController, passNewWordData {
    func passDataBack(data: VocabInfo) {
        
        //deleteSelectedWord()
        
       // self.tableView.reloadData()
    // if let indexPath = tableView.indexPathForSelectedRow {
        vocabArray.insert(data, at: vocabArray.endIndex)
        vocabArray.append(data)
        //self.deleteSelectedWord()
        saveNewItems()
        //self.deleteSelectedWord()
        //vocabArray.setValue(self.editVC.editVocabTextField, forKey: "vocabTitle")
        loadAddedWords()
     //}
        //self.tableView.reloadData() You dont even need to keep calling reload data just insert the data where it should go. with the .insert method. Only do this when all the data has been changed.
        self.dismiss(animated: true) {
  
        }

    }
    //Removed edit function as can't get it to update correctly in the tableview.
    
    @IBOutlet weak var wordSearchBar: UISearchBar!
    
 
    var vocabArray = [VocabInfo]()
    
    let editVC = EditViewController()
    
    let mainVC = MainViewController()

    @IBOutlet weak var goToAddVCButton: UIBarButtonItem!
    
    //let savedWordsArray = [vocabInfo.returnAllWordDataForN1().0]
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //this is how you get access to your context for Core Data.
   // let context1 = CoreDataManager.persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()
       // searchController.searchBar.barStyle = .black
        wordSearchBar.searchTextField.textColor = .white
        wordSearchBar.delegate = self //DON'T FORGET THIS!!! SEARCH BAR WON'T DO ANYTHING WITHOUT SETTING DELEGATE!
       //let testArray = ["通知","ウイジェット","検索"] //outside of viewDidLoad
        
        let addVocabController = AddVocabularyViewController()
        addVocabController.delegate = self
        
        title = "Search Words"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Word", style: .plain, target: self, action: #selector(goToAddWords(_:)))
        loadAddedWords() // COOL! It now loads the words from the context!!!
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
        //really crucial! Remember to provide a default value with the equals sign here so it can retrieve the data you originally asked, so we don't have to constantly call the fetchRequest over and over
       // let request: NSFetchRequest<VocabInfo> = VocabInfo.fetchRequest() //YOU HAVE TO SPECIFY THE DATA TYPE HERE! The app will not compile if you don't
        //after refactoring, we don't need this constant as it's getting in the way of fetching the correct request.
        
        do {
          vocabArray = try context.fetch(request) //result of call fetch is unused. So we need to put it into a tableview.
        } catch  {
            print("Error loading context: \(error)")
        }
        //context.fetch(request) throws errors so move to the fetch request.
       //tableView.reloadData()
        
//        let indexPath = IndexPath(row: 1, section: 0)
//        //tableView.insertRows(at: [indexPath], with: .fade)
//        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
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
//    func load() {
//        mainVC.loadNewWord()
//    }
//    func goToAddWords(_: UIButton) {
//        performSegue(withIdentifier: "searchToAdd", sender: self)
//    }
//    @objc func goToAddWords(_ sender: Any) {
//        performSegue(withIdentifier: "searchToAdd", sender: self)
//
//
//    }
    @objc func goToAddWords(_ sender: Any) {
        
        performSegue(withIdentifier: "searchToAdd", sender: self)
        
    }
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return testArray.count //DON'T NEED THIS!! USE THE BELOW METHOD!
//    }

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
        //let vocabArrayData = vocabArray[indexPath.row] //index out of range error...
//        let testArray1 = testArray[indexPath.row]
//        //cell.textLabel?.text = vocabArrayData.vocabTitle
//        cell.textLabel?.text = testArray1
        //ok remember this is how you populate the cell.
        
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
                self.saveNewItems()
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }))
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(ac, animated: true) {
               
            }
            }
            
//            context.delete(vocabArray[indexPath.row]) //ok seems to be deleting from the context here...
//            vocabArray.remove(at: indexPath.row)
            
           // tableView.deleteRows(at: [indexPath], with: .fade) //index path should be in an array.
            tableView.endUpdates()
        }
    


//MARK: - Table View Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print(testArray[indexPath.row])
        //print(vocabInfo.returnAllWordDataForN1())
        
        //remember how to deselectRow to avoid the grey box staying there when selected.
        
       // performSegue(withIdentifier: "goToEditVC", sender: self)
 

       tableView.deselectRow(at: indexPath, animated: true) //this is just gonna confuse the user if you keep it in and it doesn't do anything.
    }
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    if let addVocabVC = segue.destination as? AddVocabularyViewController {
           addVocabVC.delegate = self

        //if let editVC = segue.destination as? EditViewController {
            //let vocabArray = vocabArray[indexPath.row]

            //editVC.loadEditData()
//            if let indexPath = tableView.indexPathForSelectedRow {
//                //YEAAAAAH!! This was the solution!!!! It now accesses and shows the data of the core data object when selecting at the indexpath!
//            //let vocabNo = vocabNumber
//            //let indexPath = IndexPath.init()
//            editVC.vocabData = vocabArray[indexPath.row].vocabTitle //reading at 0 is working but only for 0 in the tableview...
//            editVC.hiraganaData = vocabArray[indexPath.row].vocabHiragana
//            editVC.englishTranslationData = vocabArray[indexPath.row].englishTranslation
////            editVC.hiraganaData = vocabBuilder.vocabArray[vocabNumber].vocabHiragana
////            editVC.englishTranslationData = vocabBuilder.vocabArray[vocabNumber].englishTranslation
//            //index out of range error when selecting words in the tableview. I need to figure out a way to load the data at the indexPath.row thats selected.
//           //loadAddedWords()
//            editVC.delegate = self
//            }
            
            
            
        }
        //editVC.delegate = self

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
    //this needs some hard refactoring its so bad...but for now it works.
        //found this solution on the NSPredicate cheat sheet online and S.O.
        //used guard let on searchBar.text, optionals are unwrapped.
        
//        request.predicate = NSPredicate(format: "vocabHiragana CONTAINS[cd] %@", searchBar.text!)
//        request.predicate = NSPredicate(format: "englishTranslation CONTAINS[cd] %@", searchBar.text!)
        //remember you need a predicate to handle this data and then in the format CONTAINS and %@ sign to check the VocabInfo array. The format string is from ObjC.
        //Remember NSPredicate cheatsheet on the Realm website.
        
        //Thread 1: "unimplemented SQL generation for predicate : (title CONTAINS \"通知\")" needed [cd] to make this work remember diacritic and adding this c = case d = diacritic
        //Thread 1: "keypath title not found in entity VocabInfo" when using title MATCHES with NSpredicate.　"title == %@"　same as before...
        //PROBLEM SOLVED. vocabTitle had to be the searchable entity here and in the sort descriptor
       // request.predicate = predicate
        
        //now we need to sort the data
        request.sortDescriptors = [NSSortDescriptor(key: "vocabTitle", ascending: true), NSSortDescriptor(key: "vocabHiragana", ascending: true), NSSortDescriptor(key: "englishTranslation", ascending: true)] //must be the same string as in the predicate
        //NSSortDescriptor(key: "vocabHiragana", ascending: true), NSSortDescriptor(key: "englishTranslation", ascending: true)
        loadAddedWords(with: request)
        
        //tableView.reloadData()
        //request.sortDescriptors = [sortDescriptor]
        //even though it's plural we can add just the one sortDescriptor to the array here.
        //as we're fetching data again we need to call our fetch function with a do catch block to handle errors
//        do {
//            vocabArray = try context.fetch(request) //fetch the request we made in the search bar to the vocaArray
//        } catch {
//            print("Error fetching data from the context \(error)")
//        }
//
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       // searchBar.barStyle = .black
        if searchBar.text?.count == 0 { //Cannot assign to property: 'count' is a get-only property should be == not =
            loadAddedWords() // calls default request to load data
            //text deletes and returns properly now.
            DispatchQueue.main.async {
                searchBar.resignFirstResponder() //to remove the keyboard from the view just like in the EditVC.
            }// update on main thread using GCD
           // searchBar.resignFirstResponder() //to remove the keyboard from the view just like in the EditVC.
        }
    }
}

