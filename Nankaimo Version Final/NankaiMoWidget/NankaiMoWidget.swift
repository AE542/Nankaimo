//
//  NankaimoWidget.swift
//  NankaimoWidget
//
//  Created by Mohammed Qureshi on 2021/05/21.
//

//2021/05/21 ok so the way to get the widget to show up is to add a widget extension to the app here. It must be used for iOS14.1 or above as previous versions of iOS don't support widgets.
//- selecting the Target Membership for the swift files you want to use in the app is crucial (Selected the CoreData model + vocabManager and the MainVC)

//import WidgetKit
//import SwiftUI
//import Intents
//
//removed boilerplate Provider struct code and moved it to its own file.
//struct NankaimoEntry: TimelineEntry {
//    let date: Date
//    let configuration: ConfigurationIntent
//} //pass this over to the WidgetExtensionFile you created.
//
//struct NankaimoWidgetEntryView : View {
//    var entry: Provider.Entry
//
//    var body: some View {
//        Text(entry.date, style: .time)
//
//    }
//}
//
//@main
//struct NankaimoWidget: Widget {
//    let kind: String = "NankaimoWidget"
//
//    var body: some WidgetConfiguration {
//        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
//            NankaimoWidgetEntryView(entry: entry)
//        }
//        .configurationDisplayName("Nankaimo") // change name of widget here
//        .description("Make your own Japanese flashcards")
//        //if you want to add supported family sizes you have to do it in this struct
//        .supportedFamilies([.systemSmall, .systemMedium]) //must be in an array
//        //now we need to create two new interfaces for both systemSmall and systemMedium
//    }
//}
//
//struct NankaimoWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        NankaimoWidgetEntryView(entry: NankaimoEntry.testVocab())
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}

