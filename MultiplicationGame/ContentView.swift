//
//  ContentView.swift
//  MultiplicationGame
//
//  Created by Matt Haffner on 6/21/21.
//

import SwiftUI

struct SettingsView: View {
    @State private var numberQuestion = 0
    @State private var numberTables = 1
    
    let numberQuestions = ["5", "10", "20", "All"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Practice tables up to")) {
                    Stepper(value: $numberTables, in: 1...12) {
                        Text("\(numberTables)")
                    }
                }
                
                Section(header: Text("Number of problems")) {
                    Picker("Number of problems", selection: $numberQuestion) {
                        ForEach(0 ..< numberQuestions.count) {
                            Text("\(self.numberQuestions[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
            }
            .navigationTitle("Multiplication Tables")
            .toolbar{
                Button("Start Game!") {
                    
                }
            }
        }
    }
}

struct GameView: View {
    var body: some View {
        Text("Game view")
    }
}

struct ContentView: View {
    @State private var gameRunning = true
    @State private var question = [(Double, Double)]()
    @State private var currentQuestions = 0
    @State private var score = 0
    
    var body: some View {
        Group {
            if gameRunning {
                GameView()
            } else {
                SettingsView()
            }
        }
    }
    
    func newGame() {
        
    }
    
    func generateQuestions() {
        
    }
    
    func checkAnswer() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
