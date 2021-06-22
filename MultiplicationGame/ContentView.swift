//
//  ContentView.swift
//  MultiplicationGame
//
//  Created by Matt Haffner on 6/21/21.
//

import SwiftUI

struct SettingsView: View {
    @State private var numberQuestion = 0
    
    let numberQuestions = ["5", "10", "20", "All"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    
                }
                
                Section(header: Text("Number of problems")) {
                    Picker("Number of problems", selection: $numberQuestion) {
                        ForEach(0 ..< numberQuestions.count) {
                            Text("\(self.numberQuestions[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    Button("Start Game!") {
                        
                    }
                }
            }
            .navigationTitle("Multiplication Tables")
        }
    }
}

struct GameView: View {
    var body: some View {
        Text("Game view")
    }
}

struct ContentView: View {
    @State private var gameRunning = false
    
    var body: some View {
        Group {
            if gameRunning {
                GameView()
            } else {
                SettingsView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
