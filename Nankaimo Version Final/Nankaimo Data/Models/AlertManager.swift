//
//  AlertManager.swift
//  ProtoKanjiAppV.3
//
//  Created by Mohammed Qureshi on 2021/05/04.
//

//For the purposes of refactoring all the alert controllers, because there are far too many all over this project.

import UIKit //has to be UIKit to get access to Alert Controller

let vocabBuilder = VocabBuilder()
struct Alert {
    static func showWarningAlertController(on vc: UIViewController, with title: String, message: String) {
        //You can also define methods that are called on the type itself. These kinds of methods are called type methods. (This is why we need the function just called on this type) From the Swift Language Guide.
        let imageAttachment = NSTextAttachment()
         imageAttachment.image = UIImage(systemName: "exclamationmark.triangle")?.withTintColor(.red)

        let fullString = NSMutableAttributedString(string: title)
        fullString.append(NSAttributedString(attachment: imageAttachment))

        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
       ac.setValue(fullString, forKey: "attributedTitle")
        vc.present(ac, animated: true)
        //cannot use just present, need to add which vc it will be presented on here we use vc from the param
    }

}
