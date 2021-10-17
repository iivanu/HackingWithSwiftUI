//
//  ContentView.swift
//  Edutainment
//
//  Created by Ivan Ivanušić on 16.10.2021..
//

import SwiftUI

enum numberOfQuestionsEnum: Int, CaseIterable {
    case five = 0
    case ten
    case twenty
    case all
    
    func enumToNumber() -> Int {
        switch self {
        case .five:
            return 5
        case .ten:
            return 10
        case .twenty:
            return 20
        case .all:
            return 100
        }
    }
    func enumToString() -> String {
        switch self {
        case .five:
            return "Five"
        case .ten:
            return "Ten"
        case .twenty:
            return "Twenty"
        case .all:
            return "All"
        }
    }
}

struct ContentView: View {
    
    @State private var isGameStarted = false
    
    @State private var minNumber = 1
    @State private var maxNumber = 12
    @State private var firstNum = 0
    @State private var secondNum = 0
    
    @State private var numberOfQuestions = numberOfQuestionsEnum.five
    @State private var questionsCount = 0
    
    @State private var selectedAnswer = ""
    @State private var label = ""

    @State private var showingAlert = false
    
    var body: some View {
        if !isGameStarted {
            NavigationView {
                Form {
                    Stepper("Minimum number", value: $minNumber, in: 1...12)
                    Text("Value: \(minNumber)")
                    Stepper("Maximum number", value: $maxNumber, in: 1...12)
                    Text("Value: \(maxNumber)")
                    Picker("How many questions? ", selection: $numberOfQuestions) {
                        ForEach(numberOfQuestionsEnum.allCases, id: \.self) { value in
                            Text(value.enumToString()).tag(value)
                        }
                    }
                    Button("Start game") {
                        startGame()
                    }
                }

                .navigationBarTitle("Edutainment App")
            }
        } else {
            NavigationView {
                Form {
                    Text(label)
                    TextField("Answer", text: $selectedAnswer)
                    Button("Check answer") {
                        checkAnswer()
                    }
                }

                .navigationBarTitle("Edutainment App")
            }
            .alert(isPresented: $showingAlert) {
                if !isGameStarted {
                    return Alert(title: Text("Game over"), message: Text("Start new game?"), dismissButton: .default(Text("Ok"), action: {
                        showingAlert = false
                    }))
                } else {
                    return Alert(title: Text("Wrong answer"), message: Text("Try again"), dismissButton: .default(Text("Ok"), action: {
                        showingAlert = false
                    }))
                }
            }
        }
    }
    
    func startGame() {
        isGameStarted = true
        askQuestion()
    }
    
    func askQuestion() {
        firstNum = Int.random(in: minNumber...maxNumber)
        secondNum = Int.random(in: minNumber...maxNumber)
        label = "What is \(firstNum) x \(secondNum) ?"
    }
    
    func checkAnswer() {
        if questionsCount >= maxNumberOfQuestions() {
            isGameStarted = false
            questionsCount = 0
            showingAlert = true
            
        } else if firstNum * secondNum == Int(selectedAnswer) {
            questionsCount += 1
            selectedAnswer = ""
            askQuestion()
        } else {
            showingAlert = true
        }
    }
    
    func maxNumberOfQuestions() -> Int {
        switch numberOfQuestions {
        case .five, .ten, .twenty:
            return numberOfQuestions.enumToNumber()
        case .all:
            return (maxNumber - minNumber + 1) * (maxNumber - minNumber + 1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
