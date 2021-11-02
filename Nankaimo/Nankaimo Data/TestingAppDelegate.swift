//
//  TestingAppDelegate.swift
//  ProtoKanjiAppV.3
//
//  Created by Mohammed Qureshi on 2021/09/30.
//

//import UIKit
//import CoreData
//
//
//@objc(TestingAppDelegate) //create this in objc so we can find it in our code elsewhere.
//
//class TestingAppDelegate: UIResponder, UIApplicationDelegate {
//
////static let shared = AppDelegate()
////let coreDataManager = CoreDataManager()
//    
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch.
//        
//        //print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as String)
//        //for printing filepath
//        print("Launching Testing App Delegate")
//        
//        return true
//    }
//
//    func applicationWillTerminate(_ application: UIApplication) {
//        self.saveContext()
//    }
//
//    //MARK: - Core Data Container Method
//    //need to copy the standard code that comes with a core data file
//    
//    lazy var applicationDocumentsDirectory: URL = {
//        let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.nankaimo.widget")!
//       return containerURL
//    }()//container directory should be updated... maybe add this to the container below.
//    
//    lazy var persistentContainer: NSPersistentContainer = { //IMPORT CORE DATA ABOVE OTHERWISE IT WON'T RECOGNISE THE NSFILE HERE.
//        //cannot convert value of type ()->() to type ns container because no container returned at the end of this code block
//    //    //lazy var are only loaded with a value at the time they're used. Get's a memory benefit.
//            let container = NSPersistentContainer(name: "VocabDataModel") // CHANGE NAME TO NAME OF CORE DATA FILE.
//            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//                if let error = error as NSError? {
//
//                    fatalError("Unresolved error \(error), \(error.userInfo)")
//                    //logs errors
//                }
//            })
//            return container
//    //
//}()
//
//        // MARK: - Core Data Saving Methods
//    //}
//        func saveContext () {
//            let context = persistentContainer.viewContext
//            //context is an area where you can modify data and then save it to permanent container. It's like the staging area for GitHub, before you make a commit.
//            if context.hasChanges {
//                do {
//                    try context.save()
//                } catch {
//                    // Replace this implementation with code to handle the error appropriately.
//                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                    let nserror = error as NSError
//                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//                }
//            }
//        }
//
//}


//This was its own file but we had to remove it because it wouldn't allow the app to run as this file interferes with the @main line in the AppDelegate
//  mainTest.swift
//  ProtoKanjiAppV.3
//
//  Created by Mohammed Qureshi on 2021/10/01.
//
//import UIKit

//let appDelegateClass: AnyClass = NSClassFromString("TestingAppDelegate") ?? AppDelegate.self //we need to use NCO here to make sure that AnyClass retrieves the TestingAppDelegate and if that fails, just the regular AppDelegate.
// UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(appDelegateClass))
//if we run the program now, it will show launching with TestingAppDelegate and not from the regular AppDelegate. Even if you stop as the test runs, it shows that the TestingAppDelegate is being used.

//before there was an expressions aren't allowed at the top level error on the UIApplicationMain line above. The reasoning for this is because the file itself needs to be named main.swift so it can act like the main entry point for the app

//from S.O; earlier we said top-level code isn’t allowed in most of your app’s source files. The exception is a special file named “main.swift”, which behaves much like a playground file, but is built with your app’s source code. The “main.swift” file can contain top-level code, and the order-dependent rules apply as well. In effect, the first line of code to run in “main.swift” is implicitly defined as the main entrypoint for the program. This allows the minimal Swift program to be a single line — as long as that line is in “main.swift”.

