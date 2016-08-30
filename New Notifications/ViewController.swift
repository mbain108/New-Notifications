//
//  ViewController.swift
//  New Notifications
//
//  Created by Melissa Bain on 8/30/16.
//  Copyright © 2016 MB Consulting. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {

        super.viewDidLoad()

        // 1. Request Permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
        
            if granted {
                print("Notification access granted")
            } else {
                print(error?.localizedDescription)
            }
        })
    }

    func scheduleNotifcation(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
        
        // Add an attachment
        let myImage = "Butterfly on Heart"
        
        guard let imageURL = Bundle.main.url(forResource: myImage, withExtension: "jpg") else {
            completion(false)
            return
        }
        
        var attachment: UNNotificationAttachment
        
        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageURL, options: .none)
        
        // Basic Notification
        let notif = UNMutableNotificationContent()
        
        // Only for extension
        notif.categoryIdentifier = "myNotificationCategory"
        
        notif.title = "New Notification"
        notif.subtitle = "These are great!"
        notif.body = "The new notification options in iOS 10 are what I've always dreamed of!"
        
        notif.attachments = [attachment]
        
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notifTrigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                print(error)
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    @IBAction func notifyButtonPressed(_ sender: UIButton) {
        
        scheduleNotifcation(inSeconds: 5) { (success) in
            if success {
                print("Successfully scheduled a notification")
            } else {
                print("Error scheduling notification")
            }
        }
    }
}
