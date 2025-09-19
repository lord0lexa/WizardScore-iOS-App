//
//  SetStingView.swift
//  Wizard Helper
//
//  Created by Alexandra Zwinger on 18.09.25.
//

import SwiftUI

struct SetStingView: View {
    @EnvironmentObject var userData: UserData
    var user: User
    @State var stingCount: String
    var backAction: () -> Void
    var forwardAction: () -> Void
    var body: some View {
        VStack {
            HStack {
                Text("Trumpf: ")
                userData.currentTrump?.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            }
            Text("Runde " + String(userData.currentRound ?? 0))
            Text(user.name)
            Text("Vorhergesagte Stiche: " + "\(user.currentGuess ?? 0)")
            HStack(spacing: 5) {
                RoundButton(icon: Image(systemName: "chevron.left")) {
                    if let index = userData.users.firstIndex(where: { $0.id == user.id }) {
                        userData.users[index].currentStings = Int(stingCount) ?? 0
                    }
                    backAction()
                }
                RoundButton(icon: Image(systemName: "minus")) {
                    if let count = Int(stingCount) {
                        stingCount = String(count - 1)
                    }
                }
                .padding(8)
                Numberfield(text: $stingCount)
                RoundButton(icon: Image(systemName: "plus")) {
                    if let count = Int(stingCount) {
                        stingCount = String(count + 1)
                    }
                }
                .padding(8)
                RoundButton(icon: Image(systemName: "chevron.right")) {
                    if let index = userData.users.firstIndex(where: { $0.id == user.id }) {
                        userData.users[index].currentStings = Int(stingCount) ?? 0
                    }
                    forwardAction()
                }
            }
            .padding(.horizontal)
            
            GoButton(label: "Richtig geraten?") {
                if let index = userData.users.firstIndex(where: { $0.id == user.id }) {
                    let guess = userData.users[index].currentGuess ?? 0
                    userData.users[index].currentStings = guess
                    stingCount = "\(guess)"
                    forwardAction()
                }
            }
        }
        .font(.title)
        .foregroundStyle(.white)
    }
}
