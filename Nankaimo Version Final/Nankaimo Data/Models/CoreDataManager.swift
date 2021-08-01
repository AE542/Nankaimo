//
//  CoreDataManager.swift
//  ProtoKanjiAppV.3
//
//  Created by Mohammed Qureshi on 2021/06/09.
//

//import CoreData
//
//class CoreDataManager {
////MARK: - Core Data Container Method
////need to copy the standard code that comes with a core data file
//static let shared = CoreDataManager()
//var persistentContainer: NSPersistentContainer = { //IMPORT CORE DATA ABOVE OTHERWISE IT WON'T RECOGNISE THE NSFILE HERE.
//    //cannot convert value of type ()->() to type ns container because no container returned at the end of this code block
////    //lazy var are only loaded with a value at the time they're used. Get's a memory benefit.
//        let container = NSPersistentContainer(name: "VocabDataModel") // CHANGE NAME TO NAME OF CORE DATA FILE.
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//                //logs errors
//            }
//        })
//        return container
////
//}()
//
//    // MARK: - Core Data Saving Methods
////}
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        //context is an area where you can modify data and then save it to permanent container. It's like the staging area for GitHub, before you make a commit.
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
//}
