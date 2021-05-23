//
//  Provider.swift
//  NankaimoWidgetExtension
//
//  Created by Mohammed Qureshi on 2021/05/23.
//

//Remember to set the target to the Widget Extension and not the Main App.

import WidgetKit

struct Provider: IntentTimelineProvider {
//    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<NankaimoEntry>) -> Void) {
//        <#code#>
//    }
    
    let vocabInfo = VocabBuilder()
    
   // let loader: VocabInfo = VocabInfo()
    let loader: VocabBuilder = VocabBuilder()
    
    func placeholder(in context: Context) -> NankaimoEntry {
        NankaimoEntry.testVocab()
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (NankaimoEntry) -> ()) {
        let entry = NankaimoEntry.testVocab() //missing completion
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        //loader.vocabTitle.index(after: loader.vocabTitle.startIndex)
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: <#T##DateComponents#>, to: <#T##Date#>)
        vocabInfo.returnAllWordDataForN1().vocabTitle
        
}
}
