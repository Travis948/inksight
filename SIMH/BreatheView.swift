//
//  BreatheView.swift
//  SIMH
//
//  Created by Travis on 18/6/2025.
//

import SwiftUI

struct BreatheView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Box Breathing")) {
                    NavigationLink(destination: BoxBreathing()) {
                        Label("Start Box Breathing", systemImage: "square.dashed")
                    }
                }

                Section(header: Text("4-7-8 Breathing")) {
                    NavigationLink(destination: FourSevenEightBreathing()) {
                        Label("Start 4-7-8 Breathing", systemImage: "wind")
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Breathing")
            .background(Color("Default-Color"))
        }
    }
}



struct BoxBreathing: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var phase = 0
    @State private var scale: CGFloat = 1.0
    @State private var instruction = "Inhale"

    @State private var timeRemaining = 60
    @State private var timerRunning = true

    let phases = ["Inhale", "Hold", "Exhale", "Hold"]
    let durations: [Double] = [4.5, 4.5, 4.5, 4.5] // same duration per phase

    var body: some View {
        VStack(spacing: 40) {
            // Title
            Text("Box Breathing")
                .font(.title)
                .fontWeight(.semibold)

            // Countdown Timer
            Text("Time left: \(timeRemaining) sec")
                .font(.subheadline)
                .foregroundColor(.secondary)

            // Breathing Instruction
            Text(instruction)
                .font(.largeTitle)
                .fontWeight(.bold)
                .transition(.opacity)
                .animation(.easeInOut, value: instruction)

            // Circle Animation
            Circle()
                .strokeBorder(Color.pink, lineWidth: 4)

                .frame(width: 200 * scale, height: 200 * scale)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Stretch to fill
        .background(Color("Default-Color").ignoresSafeArea()) // Full background
        .onAppear {
            startBreathing()
            startCountdown()
        }
        
    }
    

    func startBreathing() {
        runPhase()
    }

    func runPhase() {
        instruction = phases[phase]

        withAnimation(.easeInOut(duration: durations[phase])) {
            switch instruction {
                case "Inhale":
                    scale = 1.0
                case "Exhale":
                    scale = 0.8
                case "Hold":
                    break
                default:
                    break
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + durations[phase]) {
            guard timeRemaining > 0 else { return }
            phase = (phase + 1) % phases.count
            runPhase()
        }
    }

    func startCountdown() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer.invalidate()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}



struct FourSevenEightBreathing: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var phaseIndex = 0
    @State private var scale: CGFloat = 1.0
    @State private var instruction = "Inhale"

    let phases = ["Inhale", "Hold", "Exhale"]
    let durations: [Double] = [4, 7, 8]

    @State private var timeRemaining = 60 // 1 minute in seconds
    @State private var timerRunning = true

    var body: some View {
        VStack(spacing: 40) {
            // Title
            Text("4-7-8 Breathing")
                .font(.title)
                .fontWeight(.semibold)

            // Countdown Timer
            Text("Time left: \(timeRemaining) sec")
                .font(.subheadline)
                .foregroundColor(.secondary)

            // Breathing Instruction
            Text(instruction)
                .font(.largeTitle)
                .fontWeight(.bold)
                .transition(.opacity)
                .animation(.easeInOut, value: instruction)

            // Breathing Circle
            Circle()
                .strokeBorder(Color.pink, lineWidth: 4)

                .frame(width: 200 * scale, height: 200 * scale)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Stretch to fill
        .background(Color("Default-Color").ignoresSafeArea()) // Full background
        .onAppear {
            startBreathing()
            startCountdown()
        }
    }

    // Breathing Logic
    func startBreathing() {
        runPhase()
    }

    func runPhase() {
        instruction = phases[phaseIndex]

        withAnimation(.easeInOut(duration: durations[phaseIndex])) {
            switch instruction {
                case "Inhale":
                    scale = 1.0
                case "Exhale":
                    scale = 0.8
                case "Hold":
                    break
                default:
                    break
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + durations[phaseIndex]) {
            guard timeRemaining > 0 else { return }
            phaseIndex = (phaseIndex + 1) % phases.count
            runPhase()
        }
    }

    // Timer Countdown
    func startCountdown() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer.invalidate()
                // Auto-dismiss view
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}










#Preview {
    BreatheView()
}
