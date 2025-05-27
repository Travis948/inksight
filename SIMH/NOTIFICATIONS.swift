//
//  NOTIFICATIONS.swift
//  SIMH
//
//  Created by Travis on 20/7/2025.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager() // Singleton

    private init() {}

    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted")
            } else if let error = error {
                print("Error requesting notifications permission: \(error.localizedDescription)")
            }
        }
    }

    func scheduleDailyReminder(hour: Int = 20, minute: Int = 0) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["dailyEmotionReminder"])

        let content = UNMutableNotificationContent()
        content.title = "Emotion Reminder"
        content.body = "Remember to answer your daily question!"
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "dailyEmotionReminder", content: content, trigger: trigger)

        center.add(request) { error in
            if let error = error {
                print("Failed to schedule notification: \(error.localizedDescription)")
            }
        }
    }

    func cancelDailyReminder() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["dailyEmotionReminder"])
    }
}

