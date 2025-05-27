//
//  ContentView.swift
//  SIMH
//
//  Created by Travis on 27/5/2025.
//


import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            
            TodayView()
                .tabItem {
                    Image(systemName: "clock")
                    Text("Today")
                }
            
            
            BreatheView()
                .tabItem {
                    Image(systemName: "arrow.triangle.2.circlepath")
                    Text("Breathing")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        }
    }
}


#Preview {
    ContentView()
}



