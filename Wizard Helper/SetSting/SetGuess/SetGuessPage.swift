//
//  SetGuessPage.swift
//  Wizard Helper
//
//  Created by Alexandra Zwinger on 17.09.25.
//

import SwiftUI

struct SetGuessPage: View {
    @EnvironmentObject var userData: UserData
    var player: Player
    @State var stingCount: String
    var backwardAction: () -> Void
    var forwardAction: () -> Void
    var body: some View {
        VStack {
            header
            stingInputView
            navButtons
            Text("Übrig: " + "\(userData.summedUpStings)")
        }
        .font(.title)
        .foregroundStyle(.white)
    }
    
    private var header: some View {
        VStack {
            HStack {
                Text("Trumpf: ")
                userData.currentTrump?.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            }
            Text("Runde " + String(userData.currentRound ?? 0))
            Text(player.name)
        }
    }
    
    private var stingInputView: some View {
        HStack(spacing: 5) {
            RoundButton(icon: Image(systemName: "minus")) {
                if let count = Int(stingCount) {
                    stingCount = String(count - 1)
                }
            }
            .padding(8)
            Numberfield(text: $stingCount, maxValue: userData.currentRound ?? 1)
            RoundButton(icon: Image(systemName: "plus")) {
                if let count = Int(stingCount) {
                    stingCount = String(count + 1)
                }
            }
            .padding(8)
        }
        .padding(.horizontal)
    }
    
    private var navButtons: some View {
        HStack {
            RoundButton(icon: Image(systemName: "chevron.left")) {
                if let index = userData.player.firstIndex(where: { $0.id == player.id }) {
                    userData.player[index].currentGuess = Int(stingCount) ?? 0
                }
                backwardAction()
            }
            .padding(8)
            RoundButton(icon: Image(systemName: "chevron.right")) {
                if let index = userData.player.firstIndex(where: { $0.id == player.id }) {
                    userData.player[index].currentGuess = Int(stingCount) ?? 0
                }
                forwardAction()
            }
            .padding(8)
        }
    }
}
