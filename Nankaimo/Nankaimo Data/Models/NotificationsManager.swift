//
//  File.swift
//  ProtoKanjiAppV.3
//
//  Created by Mohammed Qureshi on 2022/01/12.
//

import UIKit
import UserNotifications


class NotificationsManager: NSObject, UNUserNotificationCenterDelegate {

    let center = UNUserNotificationCenter.current()
    let content = UNMutableNotificationContent()
    var dateComponents = DateComponents()
    
    
    func removeNotifications() {
    center.removeAllPendingNotificationRequests()
    center.removeAllDeliveredNotifications()
    center.requestAuthorization(options: [.alert, .sound]) { granted, error in
        if granted {
            print("Granted!")
        } else {
            print("Nope not granted")
        }
    }
    }
    
    //let content = UNMutableNotificationContent()
    
    func showContent() {
    content.title = "How's your studying going?"

   // content.body = "Do you remember what \(vocabBuilder.returnAllWordDataForN1().0) is in hiragana?"

    content.body = "Have you seen any new interesting words recently? Let's review the words you've added."

    content.sound = UNNotificationSound.default

    }
    
    func dateComponentsDateSet() {
    dateComponents.hour = 10
    dateComponents.minute = 30
    dateComponents.second = 00

    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

   let uuidString = UUID().uuidString
   let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)

    center.add(request)

}
}
