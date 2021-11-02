//
//  AppDelegate.swift
//  ProtoKanjiAppV.3
//
//  Created by Mohammed Qureshi on 2021/02/02.
//

import UIKit
import CoreData //don't forget you need to import this when you're using a core data model

@main //bring this back when running the app without using the TestingAppDelegate


class AppDelegate: UIResponder, UIApplicationDelegate {

//static let shared = AppDelegate()
//let coreDataManager = CoreDataManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as String)
        //for printing filepath
       // print("Launching with regular AppDelegate")
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }

    //MARK: - Core Data Container Method
    //need to copy the standard code that comes with a core data file
    
    lazy var applicationDocumentsDirectory: URL = {
        let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.nankaimo.widget")!
       return containerURL
    }()//container directory should be updated... maybe add this to the container below.
    
    lazy var persistentContainer: NSPersistentContainer = { //IMPORT CORE DATA ABOVE OTHERWISE IT WON'T RECOGNISE THE NSFILE HERE.
        //cannot convert value of type ()->() to type ns container because no container returned at the end of this code block
    //    //lazy var are only loaded with a value at the time they're used. Get's a memory benefit.
            let container = NSPersistentContainer(name: "VocabDataModel") // CHANGE NAME TO NAME OF CORE DATA FILE.
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {

                    fatalError("Unresolved error \(error), \(error.userInfo)")
                    //logs errors
                }
            })
            return container
    //
}()

        // MARK: - Core Data Saving Methods
    //}
        func saveContext () {
            let context = persistentContainer.viewContext
            //context is an area where you can modify data and then save it to permanent container. It's like the staging area for GitHub, before you make a commit.
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }


}

