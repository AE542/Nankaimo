
//
//  SearchTableViewController.swift
//  ProtoKanjiAppV.3
//
//  Created by Mohammed Qureshi on 2021/06/09.
//


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
    //adding this back in after new commit
    
    @IBOutlet weak var wordSearchBar: UISearchBar!
    
    
    
    var vocabArray = [VocabInfo]()
    
    let editVC = EditViewController()
    
    let mainVC = MainViewController()

    @IBOutlet weak var goToAddVCButton: UIBarButtonItem!
    
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Word", style: .plain, target: self, action: #selector(goToAddWords(_:)))
        loadAddedWords() // COOL! It now loads the words from the context!!!
        
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
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
                self.saveNewItems()
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }))
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            present(ac, animated: true) {
               
            }
            }
            
            tableView.endUpdates()
        }
    


//MARK: - Table View Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

       tableView.deselectRow(at: indexPath, animated: true) //this is just gonna confuse the user if you keep it in and it doesn't do anything.
    }
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    if let addVocabVC = segue.destination as? AddVocabularyViewController {
           addVocabVC.delegate = self

            
        }


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

