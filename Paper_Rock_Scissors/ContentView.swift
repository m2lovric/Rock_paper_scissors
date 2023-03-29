//
//  ContentView.swift
//  Paper_Rock_Scissors
//
//  Created by Matteo Lovrić on 28.03.2023..
//

import SwiftUI

struct ContentView: View {
    @State var appPick = Int.random(in: 0 ... 2)
    @State var userScore = 0
    @State var userPick = 0
    @State var arr = ["rock", "scissors", "paper"]
    @State var winOrLose = true
    @State var showAlert = false
    @State var showFighter = false

    struct alertStruct {
        var show: Bool
        var message: String
    }

    @State var alertMessage = alertStruct(show: false, message: "")
    var turns = 5

    func win(_ index: Int) {
        userPick = index
        if userPick == 0 && appPick == 2 {
            winOrLose ? (userScore -= 1) : (userScore += 1)
            alertMessage.show = true
            alertMessage.message = "App pick \(arr[appPick]): You lost"
        } else if userPick < appPick {
            winOrLose ? (userScore += 1) : (userScore -= 1)
            alertMessage.show = true
            alertMessage.message = "App pick \(arr[appPick]): You won"
        } else if userPick == appPick {
            alertMessage.show = true
            alertMessage.message = "App pick \(arr[appPick]): It's draw"
        } else {
            winOrLose ? (userScore -= 1) : (userScore += 1)
            alertMessage.show = true
            alertMessage.message = "App pick \(arr[appPick]): You lost"
        }
    }

    var body: some View {
        VStack {
            Spacer()
            showFighter
                ? Text("Choose your fighter")
                .font(.title.weight(.bold))
                : Text("Rock scissors paper")
                .font(.title.weight(.bold))

            VStack {
                showFighter ?
                    Group {
                        ForEach(Array(arr.enumerated()), id: \.offset) { index, item in
                            Button(action: { win(index) }) {
                                Image(item)
                                    .renderingMode(.original)
                                    .resizable()
                                    .frame(width: 64, height: 64)
                                    .scaledToFit()
                            }
                            .frame(width: 128, height: 128)
                            .background(.white)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                            .padding(20)
                        }.alert(alertMessage.message, isPresented: $alertMessage.show) {
                            Button("Next game") {
                                appPick = Int.random(in: 0 ... 2)
                            }
                        }
                        Text("Score: \(userScore)")
                        Spacer()
                        Button("Reset game"){
                            showFighter = false
                            userScore = 0
                        }
                    } : nil
            }
            Spacer()
            showFighter ?
                nil :
            Group {
                Button("Start game") {
                    showAlert = true
                }
                .alert("Win or Lose", isPresented: $showAlert) {
                    Button("Win") {
                        winOrLose = true
                        showFighter = true
                    }
                    Button("Lose") {
                        winOrLose = false
                        showFighter = true
                    }
                    
                }
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
