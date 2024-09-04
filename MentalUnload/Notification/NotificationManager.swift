//
//  NotificationHManager.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 28.07.24.
//


//
//  NotifikationHandler.swift
//  SnapButton
//
//  Created by Dagmar Feldt on 16.07.24.
//

import SwiftUI
import CoreLocation

class NotificationManager {
    static var permissionGranted = false
    //private let notificationCenter = UNUserNotificationCenter.current()
    static func requestPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                permissionGranted = true
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    static func sendNotification(snapTask: SnapTask) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "\(snapTask.name)"
        notificationContent.subtitle = "You should take care of the task: '\(snapTask.name)' again."

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let req = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)

        UNUserNotificationCenter.current().add(req)
    }
   

}

