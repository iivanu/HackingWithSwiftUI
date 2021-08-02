//
//  ContentView.swift
//  Paper Rock Scissors
//
//  Created by Ivan Ivanušić on 02.08.2021..
//

import SwiftUI

struct ContentView: View {
    let choices = ["Rock", "Paper", "Scissors"]
    
    @State private var gameChoice = Int.random(in: 0..<3)
    @State private var isWinning = Bool.random()
    @State private var score = 0
    @State private var moves = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""

    
    
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                VStack {
                Text("Moves: \(moves)")
                Text("Score: \(score)")
                }.padding()
                VStack(spacing: 40) {
                    VStack(spacing: 10) {
                        Text("Game choose: \(choices[gameChoice])")
                        Text("Is winning: \(String(isWinning))")
                    }
                    
                    HStack(spacing: 20) {
                        ForEach(0 ..< 3) { number in
                            Button(action: {
                                self.choiceTapped(number)
                            }) {
                                Text(choices[number])
                            }
                        }
                    }
                }
            }
            .alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                })
            }
        }
    }
    
    func choiceTapped(_ number: Int) {
        var didPlayerWon = false
        switch gameChoice {
            case 0:
                if isWinning {
                    didPlayerWon = number == 1
                } else {
                    didPlayerWon = number != 1
                }
            break
            case 1:
                if isWinning {
                    didPlayerWon = number == 2
                } else {
                    didPlayerWon = number != 2
                }
            break
            default:
                if isWinning {
                    didPlayerWon = number == 0
                } else {
                    didPlayerWon = number != 0
                }
            break
        }
        
        showAC(didPlayerWon)
    }
    
    func showAC(_ didWon: Bool) {
        moves += 1
        if didWon {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! That’s the wrong answer"
            score -= 1
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        gameChoice = Int.random(in: 0..<3)
        isWinning = Bool.random()
        
        if moves == 10 {
            score = 0
            moves = 0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
