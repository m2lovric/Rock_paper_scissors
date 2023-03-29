//
//  ContentView.swift
//  Paper_Rock_Scissors
//
//  Created by Matteo Lovrić on 28.03.2023..
//

import SwiftUI

struct ContentView: View {
    var appPick = Int.random(in: 1 ... 3)
    @State var arr = ["rock", "paper", "scissors"]
    @State var winOrLose = true
    @State var showAlert = false
    @State var showFighter = false

    var body: some View {
        VStack {
            Spacer()
            showFighter
            ? Text("Choose your fighter")
                .font(.title.weight(.bold))
            : Text("Rock paper scissors")
                .font(.title.weight(.bold))

            VStack {
                showFighter ? ForEach(arr, id: \.self) { item in
                    Button(action: {print(item)}) {
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
                } : nil
            }
            Spacer()
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
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
