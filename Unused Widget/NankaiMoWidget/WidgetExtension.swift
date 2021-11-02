//
//  WidgetExtension.swift
//  ProtoKanjiAppV.3
//
//  Created by Mohammed Qureshi on 2021/06/10.
//

import WidgetKit
import SwiftUI
import Intents
import UIKit
import CoreData
import Foundation

//public enum AppGroup: String {
//    case vocab = "group.nankaimo.widget"
//
//
//public var containerURL: URL {
//    switch self {
//    case .vocab:
//        return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: self.rawValue)!
//    }
//}
//}
//
//let storeURL = AppGroup.vocab.containerURL.appendingPathComponent("VocabDataModel.sqlite")
//let description = NSPersistentStoreDescription(url: storeURL)
//let container = NSPersistentContainer(name: "VocabDataModel")
//let persistentContainer = container.persistentStoreDescriptions = [description]
//let stores = container.loadPersistentStores {_,_ in
//}

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), vocabWord: "工事中", hiragana: "こうじちゅう")
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration, vocabWord: "言葉", hiragana: "ことば")
        completion(entry)
    }//get snapshot is when the user adds the widget on the homescreen and sees a default widget that they can add.

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        
        //attempt to import CoreData
        
        //let managedObjectContext =
        
        //get attribute from Core Data
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "vocabTitle")
        
        
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, vocabWord: "工事中", hiragana: "こうじちゅう")
            
            var results = [VocabInfo]()
            
            
            
//            do {
//                results = try
//            } catch let error as NSError {
//                
//            }
//            
//            
//            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

//func parseJSON() {
//    let encoder = JSONEncoder()
//    
//    do {
//        let JSONData = try encoder.encode(VocabInfo)
//    } catch {
//        
//    }
//}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let vocabInfo = [VocabInfo]()
    let vocabWord: String
    let hiragana: String
}

struct WidgetExtensionEntryView : View {
    var entry: Provider.Entry
//        .frame(width: .infinity, height: .infinity, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//        .background(Color.init(<#T##name: String##String#>))
    let vocabInfo = [VocabInfo]()
    let vocabBuilder = [VocabBuilder]()
    
    
    var body: some View {
        
        HStack { //view that arranges children in horizontal line. Good for a small number of child views.
            
            VStack(alignment: .center) { //arranges view in vertical line
                
                Text(entry.vocabWord)
                    .font(Font.system(size: 22.0)) //Cannot infer contextual base in reference to member 'font' because TEXT NOT SET!!!
                    .lineLimit(2)
                    .fixedSize(horizontal: true, vertical: true)
                    .padding()
                    .opacity(1.0)
                
                Text(entry.hiragana)
                        .font(Font.system(size: 15.0)) //Cannot infer contextual base in reference to member 'font' because TEXT NOT SET!!!
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding()
                        .opacity(1.0)
                        
                //quite simple in SwiftUI to add text box below another. they have to flow correctly in a VStack as its vertical so just like in the main app it should be word above translation below
            }
          
            .foregroundColor(.blue)
            .padding()//keeps the words inside the view //A view that pads this view inside the specified edge insets with a system-calculated amount of padding.
            .cornerRadius(7.0)
            
        }
        .frame(width: 300, height: 300, alignment: .center)
//        let words = "工事中"
//        //Text(entry.date, style: .time)
//        ZStack { //use a Zstack for setting the colour on a widget
//          // let color = UIColor(red: 0x18, green: 0x64, blue: 0)
//            //let color = UIColor(rgb: 0x1864107)
//            //Color.init(color)
//            //Color.init(red: 25.0, green: 60.0, blue: 65.0)
////            let appColour = UIColor(hex: "#12406B")
////            Color.init(red: 18.0, green: 64.0, blue: 107.0, opacity: 100.0)
////                .ignoresSafeArea()
//            Color.init(hex: "12406B")
//                .ignoresSafeArea()
//            //let color = UIColor(red: 0xFF, green: 0xFF, blue: 0xFF)
//            Text("\(words)")
//                .foregroundColor(.white)
//                .fontWeight(.bold)
//                .kerning(1.0)
//                .font(.largeTitle)
//
//        }
//
    }
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    var savedVocab: String {
//
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "VocabInfo")
//        do {
//            return try UIApplicationDelegate.shared.context.fetch(request)
//        } catch  {
//            print("Error fetching data from context: \(error)")
//        }
//    }
}

@main
struct WidgetExtension: Widget {
    let kind: String = "WidgetExtension"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            WidgetExtensionEntryView(entry: entry)
        }
        .configurationDisplayName("Nankaimo")
        .description("Show your saved words on your home screen.")
    }
}

struct WidgetExtension_Previews: PreviewProvider {
    static var previews: some View {
        WidgetExtensionEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), vocabWord: "工事中", hiragana: "こうじちゅう"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

extension Color {
    //this solution on S.0) worked for converting hex values. Now the same colour as the app
    init(hex: String) {
            let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
            var int: UInt64 = 0
            Scanner(string: hex).scanHexInt64(&int)
            let a, r, g, b: UInt64
            switch hex.count {
            case 3: // RGB (12-bit)
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6: // RGB (24-bit)
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8: // ARGB (32-bit)
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b) = (1, 1, 1, 0)
            }

            self.init(
                .sRGB,
                red: Double(r) / 255,
                green: Double(g) / 255,
                blue:  Double(b) / 255,
                opacity: Double(a) / 255
            )
        }
//    public convenience init?(hex: String) { //if we want this to always return a value we can change the init? to -> init
//        let r, g, b, a: CGFloat
//
//        if hex.hasPrefix("#") {
//            let start = hex.index(hex.startIndex, offsetBy: 1) //offset the string by 1 so we can access the hex value's numbers
//            let hexColor = String(hex[start...]) //create the string after the #
//
//            if hexColor.count == 8 {
//                let scanner = Scanner(string: hexColor) //scans hex string for values
//                var hexNumber: UInt64 = 0 //set var for hex no.
//
//                if scanner.scanHexInt64(&hexNumber) { //scan the Int for the hex number
//                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
//                    g = CGFloat((hexNumber & 0xff000000) >> 16) / 255
//                    b = CGFloat((hexNumber & 0xff000000) >> 8) / 255
//                    a = CGFloat((hexNumber & 0xff000000) >> 24) / 255
//
//                    self.init(red:r , green: g, blue: b, alpha: a) //init params with colour names
//                return
//                }
//            }
//        }
//        return nil // we can change this to reutrn UI.Color.black as a default if we want to.
//    }
    
    
    
//    public convenience init(red: Int, green: Int, blue: Int) {
//        assert(red >= 0 && red <= 255, "Invalid Red Component")
//        assert(green >= 0 && green <= 255, "Invalid Green Component")
//        assert(blue >= 0 && blue <= 255, "Invalid Blue Component")
//        //expected expression operator again because < = space in between! Should be together <=
//        self.init(red: CGFloat(red) / 255.0, green:CGFloat(green) / 255.0, blue:CGFloat(blue) / 255.0, alpha: 1.0)
//    }
//    convenience init(rgb: Int) {
//        self.init(
//            red: (rgb >> 18) & 0xFF,
//            green: (rgb >> 64) & 0xFF,
//            blue: (rgb >> 107) & 0xFF
//
//        )
//    }
}
