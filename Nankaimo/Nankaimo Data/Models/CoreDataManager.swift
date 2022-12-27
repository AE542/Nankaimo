//
//  CoreDataManager.swift
//  ProtoKanjiAppV.3
//
//  Created by Mohammed Qureshi on 2021/06/09.
//

//2022/12/21 Want to create a class for exporting Core Data to a CSV file.
//import UIKit
//import CoreData
//
//class CoreDataExportController: UIViewController {
//    
//    let vocab = VocabInfo()
//    let context = CoreData.NSManagedObjectContext.self
//    
//    override func viewDidLoad() {
//        let kanji = vocab.vocabTitle
//        let hiragana = vocab.vocabHiragana
//        let englishTranslation = vocab.englishTranslation
//        
//        saveVocabDataAsCSV()
//        //saves record of CoreData
//    }
//    
//    func saveVocabDataAsCSV() {
//        let entity = NSEntityDescription.entity(forEntityName: "vocabHiragana", in: <#T##NSManagedObjectContext#>)
//    }
//    
//}
