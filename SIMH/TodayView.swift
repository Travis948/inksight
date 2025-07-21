//
//  TodayView.swift
//  SIMH
//
//  Created by Travis on 16/6/2025.
//

import SwiftUI

struct TodayView: View {
    @State private var selectedMood: String? = UserDefaults.standard.string(forKey: "selectedMood")
    @State private var note: String = ""
    @State private var showNoteField: Bool = false

    @State private var selectedEnthusiasm: String? = nil
    @State private var enthusiasmNote: String = ""
    @State private var showEnthusiasmNoteField: Bool = false
    
    let moods = ["😄", "🙂", "😐", "😞", "😭"]
    
    var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 0..<12: return "Good morning"
        case 12..<18: return "Good afternoon"
        default: return "Good evening"
        }
    }
    
    var wellbeingMessage: String {
        guard let mood = selectedMood, let enthusiasm = selectedEnthusiasm else {
            return ""
        }

        let sadMoods = ["😐", "😞", "😭"]
        
        if !sadMoods.contains(mood) && !sadMoods.contains(enthusiasm) {
            return "You're doing okay — keep it up! 😊"
        } else {
            return "It seems you're having a tough time. Try some breathing exercises or consider talking to someone. You can call SAMH at 1800-283-7019 💙"
        }
    }

    var body: some View {
        let localTime = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)

        VStack(spacing: 20) {
            Text(localTime)
                .font(.title)
                .fontWeight(.bold)
            
            Text("\(greeting)")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
                .frame(height: 50)
            
            // First question
            VStack(spacing: 10) {
                Text("How are you feeling today?")
                    .font(.headline)
                
                HStack(spacing: 25) {
                    ForEach(moods, id: \.self) { mood in
                        Text(mood)
                            .font(.largeTitle)
                            .scaleEffect(selectedMood == mood ? 1.5 : 0.8)
                            .opacity(selectedMood == mood || selectedMood == nil ? 1.0 : 0.5)
                            .onTapGesture {
                                withAnimation {
                                    if selectedMood == mood {
                                        selectedMood = nil
                                        showNoteField = false
                                    } else {
                                        selectedMood = mood
                                        showNoteField = true
                                    }
                                }
                            }
                    }
                }

                if showNoteField, let mood = selectedMood {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Why do you feel \(mood)?")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        TextEditor(text: $note)
                            .padding(10)
                            .frame(height: 100)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray, lineWidth: 1)
                                    .background(Color.white.cornerRadius(12))
                            )
                            .padding(.horizontal)
                        
                        Button("Save Note") {
                            print("Mood: \(mood), Note: \(note)")
                            note = ""
                            showNoteField = false
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(10)
                    }
                    .padding()
                    .transition(.opacity)
                }
            }
            .padding(.bottom, 40)
            
            // Second question
            VStack(spacing: 10) {
                Text("Do you like doing the activities that you used to like?")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                HStack(spacing: 25) {
                    ForEach(moods, id: \.self) { mood in
                        Text(mood)
                            .font(.largeTitle)
                            .scaleEffect(selectedEnthusiasm == mood ? 1.5 : 0.8)
                            .opacity(selectedEnthusiasm == mood || selectedEnthusiasm == nil ? 1.0 : 0.5)
                            .onTapGesture {
                                withAnimation {
                                    if selectedEnthusiasm == mood {
                                        selectedEnthusiasm = nil
                                        showEnthusiasmNoteField = false
                                    } else {
                                        selectedEnthusiasm = mood
                                        showEnthusiasmNoteField = true
                                    }
                                }
                            }
                    }
                }

                if showEnthusiasmNoteField, let mood = selectedEnthusiasm {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Why do you feel \(mood)?")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        TextEditor(text: $enthusiasmNote)
                            .padding(10)
                            .frame(height: 100)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray, lineWidth: 1)
                                    .background(Color.white.cornerRadius(12))
                            )
                            .padding(.horizontal)
                        
                        Button("Save Note") {
                            print("Enthusiasm: \(mood), Note: \(enthusiasmNote)")
                            enthusiasmNote = ""
                            showEnthusiasmNoteField = false
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(10)
                    }
                    .padding()
                    .transition(.opacity)
                }
            }
            
            // Wellbeing message after both questions
            if !wellbeingMessage.isEmpty {
                Text(wellbeingMessage)
                    .font(.body)
                    .padding()
                    .multilineTextAlignment(.center)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .transition(.opacity)
            }

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Default-Color"))
    }
}

#Preview {
    TodayView()
}
