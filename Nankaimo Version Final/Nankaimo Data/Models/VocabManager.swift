//
//  VocabDataModel.swift
//  ProtoKanjiAppV.3
//
//  Created by Mohammed Qureshi on 2021/02/02.
//

import UIKit
import CoreData

 //changed from struct to class as we want to get this data and use it elsewhere not just call its value as with a struct...but maybe as a struct its better as we just want it to read the data only without changing it.

var vocabNumber = 0

var newVocabNo = 0

class VocabBuilder {

    var vocabArray: [VocabInfo] = [] //init an empty array of Vocab Items. Doesn't need init.

    func returnAllWordDataForN1() -> (vocabTitle:String, hiragana:String, englishTranslation:String) {
        
        if vocabArray.isEmpty {
         return(vocabTitle:"Add a Word", hiragana:"Add hiragana", englishTranslation: "Add a translation")
        } else {
           
                    return (vocabArray[vocabNumber].vocabTitle, vocabArray[vocabNumber].vocabHiragana, vocabArray[vocabNumber].englishTranslation)
            //refactored all the funcs into one tuple...should follow the same rules but how to make sure each bit of info gets put into each respective box
            //REFACTOR SUCCESSFUL! this makes all the funcs into one and now can return them as one value and read the return values using 0,1,2,3 kind of like an array

            //Tuples can have their own internal param names here so it's more clear what is being returned by the function.

                   }
    }
    

    
    func viewCount() -> Int {
        if vocabArray.isEmpty {
            return 0
        } else {
            vocabArray[vocabNumber].incrementNoOfTimesSeen()
        }

        return Int(vocabArray[vocabNumber].numberOfTimesSeen)
 
    }

    func nextVocab() {

        if vocabArray.isEmpty{
            vocabNumber = 0

        } else {
        vocabNumber = (vocabNumber + Int.random(in: vocabArray.startIndex...vocabArray.endIndex)) % vocabArray.count
        //DIVIDING BY ZERO WHEN NOTHING IS IN THE ARRAY, DON'T DO THAT!

        }
    }
    
        //changing to .endIndex seemed to allowed us to loop through all the words in the array and isn't limited to just 0...19 items.

//        //NSLog("Before", "\(vocabNumber)")
//       // vocabNumber = (vocabNumber + Int.random(in: 0...19)) % n1LevelVocab.count //remember the modulo use here to allow it to calculate the random number being shown.
//        //pictureViewCount += 1
//        //save()
//        //NSLog("After", "\(vocabNumber)")
//    }
    //old solution that taught me how to use the modulo operator.
}
