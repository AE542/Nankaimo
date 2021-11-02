//
//  VocabInfo+CoreDataProperties.swift
//  ProtoKanjiAppV.3
//
//  Created by Mohammed Qureshi on 2021/04/07.
//
//

import Foundation
import CoreData


extension VocabInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VocabInfo> {
        return NSFetchRequest<VocabInfo>(entityName: "VocabInfo")
    }

    @NSManaged public var englishTranslation: String
    @NSManaged public var numberOfTimesSeen: Int64
    @NSManaged public var vocabHiragana: String
    @NSManaged public var vocabTitle: String

    convenience init(vocabTitle: String, vocabHiragana: String, englishTranslation: String, noOfTimesSeen: Int64 ) {
        self.init()
        
       // self.vocabTitle = vocabTitle ProtoKanjiAppV_3.VocabInfo setVocabTitle:]: unrecognized selector sent to instance 0x600001ab6e80" error. This is causing problems when the app starts and instantly crashes...how do you implement a correct init here?
    }
    
    func incrementNoOfTimesSeen() {
        numberOfTimesSeen += 1
        
    }
    //didn't need a reset noOfTimesSeen func because we can just return the vocabNo again at 0.
}

extension VocabInfo : Identifiable {

}
