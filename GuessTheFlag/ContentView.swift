//
// ContentView.swift
// GuessTheFlag
//
// Created by Tensai Solutions on 10/10/23
// Copyright © 2023 Tensai Solutions. All rights reserved.


import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var numberOfQuestions = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                Spacer()
                Spacer()
                Text("Score: \(userScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))

                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            if (numberOfQuestions < 8) {
                Button("Continue", action: askQuestion)
            } else {
                Button("Restart", action: restart)
            }
        } message: {
            if (numberOfQuestions < 8) {
                Text("Your score is \(userScore)")
            } else {
                Text("Your final score was \(userScore)")
            }
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
        } else {
            scoreTitle = "Wrong that is the flag of \(countries[number])"
            userScore -= 1
        }

        numberOfQuestions += 1
        showingScore = true
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }

    func restart() {
        userScore = 0
        numberOfQuestions = 0
        askQuestion()
    }
}

#Preview {
    ContentView()
}
