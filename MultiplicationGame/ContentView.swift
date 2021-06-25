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
    
    @Binding var gameRunning: Bool
    @Binding var questions: [(Int, Int)]
    
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
                    gameRunning = true
                    generateQuestions()
                    print(questions)
                }
            }
        }
    }
    
    func generateQuestions() {
        let columns = 1...numberTables
        let rows = 1...12
        var tempArray = [(Int,Int)]()
        for x in columns {
            for y in rows {
                tempArray.append((x, y))
            }
        }
        tempArray.shuffle()
        let numQuestion = numberQuestions[numberQuestion]
        
        if numQuestion == "All" {
            questions = tempArray
        } else if numQuestion == "20" && numberTables == 1 {
            questions = tempArray
        } else {
            let startNum = Int(numQuestion)!
            tempArray.removeSubrange(startNum...)
            questions = tempArray
        }
    }
}

struct GameView: View {
    @State private var score = 0
    @State private var inputAnswer = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    @Binding var gameRunning: Bool
    @Binding var questions: [(Int, Int)]
    

    
    var body: some View {
        VStack {
            if questions.count == 0 {
                Text("Final Score: \(score)")
                Button("New Game") {
                    gameRunning = false
                }
            } else {
                Text("What is \(questions[0].0) x \(questions[0].1)?")
            
                TextField("Enter your answer", text: $inputAnswer)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                Button("Submit Answer") {
                    checkAnswer()
                }

            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Current Score: \(score)"), message: Text("\(alertMessage)"), dismissButton: .default(Text("Next Question!")))
        }
    }
    
    func checkAnswer() {
        let correctAnswer = String(Int(questions[0].0) * Int(questions[0].1))
        if correctAnswer == inputAnswer {
            score += 1
            alertMessage = "Correct!"
        } else {
            alertMessage = "Sorry, \"\(correctAnswer)\" was the correct choice."
        }
        
        inputAnswer = ""
        questions.removeFirst()
        showingAlert = true

    }
}

struct ContentView: View {
    @State private var gameRunning = false
    @State private var questions = [(Int, Int)]()

    var body: some View {
        Group {
            if gameRunning {
                GameView(gameRunning: $gameRunning, questions: $questions)
            } else {
                SettingsView(gameRunning: $gameRunning, questions: $questions)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
