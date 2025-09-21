//
//  GuessOverviewView.swift
//  Wizard Helper
//
//  Created by Alexandra Zwinger on 17.09.25.
//

import SwiftUI

struct GuessOverviewView: View {
    @EnvironmentObject var userData: UserData
    @State private var showNextView: Bool = false
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                Spacer()
                header
                userScore
                Text("Übrig: " + "\(userData.summedUpStings)")
                Spacer()
                GoButton(label: "Punkte eintragen ->") {
                    showNextView = true
                }
            }
            ResetButton()
        }
        .font(.title)
        .foregroundStyle(.white)
        .fullScreenCover(isPresented: $showNextView) {
            SetStingView()
        }
    }
    
    private var header: some View {
        VStack {
            Text("Runde " + String(userData.currentRound ?? 0))
            HStack {
                Text("Trumpf: ")
                userData.currentTrump?.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            }
        }
    }
    
    private var userScore: some View {
        ForEach(userData.player, id: \.id) { player in
            HStack(spacing: 10) {
                Text(player.name + ":")
                Text("\(player.currentGuess ?? 0)")
            }
        }
    }
}
