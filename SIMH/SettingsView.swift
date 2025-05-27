//
//  SettingsView.swift
//  SIMH
//
//  Created by Travis on 16/6/2025.
//

import SwiftUI
import UserNotifications // Import here to avoid issues with UNUserNotificationCenter

struct SettingsView: View {
 
    @State private var isDailyReminder = false

    var body: some View {
        VStack(spacing: 30) {
            Text("Settings")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Section(header: Text("Notifications")) {
                Toggle("Daily Reminder", isOn: Binding(
                    get: { isDailyReminder },
                    set: { newValue in
                        isDailyReminder = newValue
                        if newValue {
                            NotificationManager.shared.requestPermission()
                            NotificationManager.shared.scheduleDailyReminder(hour: 20, minute: 0)
                        } else {
                            NotificationManager.shared.cancelDailyReminder()
                        }
                    }
                ))
                .padding()
                .toggleStyle(SwitchToggleStyle(tint: .blue))
            }
            .padding()
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    SettingsView()
}
