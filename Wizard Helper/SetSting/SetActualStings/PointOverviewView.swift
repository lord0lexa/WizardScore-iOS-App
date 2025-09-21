//
//  PointOverviewView.swift
//  Wizard Helper
//
//  Created by Alexandra Zwinger on 18.09.25.
//

import SwiftUI

struct PointOverviewView: View {
    @EnvironmentObject var userData: UserData
    @State private var showNextView: Bool = false
    var body: some View {
        let isLastRound = userData.currentRound ?? 1 > 60 / userData.player.count
        ZStack {
            BackgroundView()
            VStack {
                Spacer()
                header
                HStack {
                    scoreBoardLabel
                    userScoreBoard
                }
                Spacer()
                nextViewButton(isLastRound: isLastRound)
            }
            ResetButton()
        }
        .font(.title)
        .foregroundStyle(.white)
        .fullScreenCover(isPresented: $showNextView) {
            if isLastRound {
                EndView()
            } else {
                SelectTrumpView()
            }
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
    
    private var scoreBoardLabel: some View {
        VStack {
            Text("-")
            ForEach(1...(userData.currentRound ?? 1), id: \.self) { index in
                Text("\(index)")
            }
            Text("----")
            Text("/")
        }
    }
    
    private var userScoreBoard: some View {
        let maxValue = userData.player.map { $0.overallPoints }.max() ?? 0

        return ForEach(userData.player, id: \.id) { player in
            VStack {
                Text(player.name)
                    .lineLimit(1)

                ForEach(player.pointHistory.keys.sorted(), id: \.self) { round in
                    let value = player.pointHistory[round] ?? 0
                    let display = value > 0 ? "+\(value)" : "\(value)"
                    Text(display)
                }
                Text("----")

                Text(String(player.overallPoints))
                    .fontWeight(player.overallPoints == maxValue ? .bold : .regular)
            }
        }
    }
    
    private func nextViewButton(isLastRound: Bool) -> some View {
        GoButton(label: isLastRound ? "Ergebnisse Ansehen" : "Nächste Runde") {
            userData.currentRound! += 1
            userData.currentTrump = nil
            for index in userData.player.indices {
                userData.player[index].currentGuess = nil
                userData.player[index].currentStings = nil
            }
            showNextView = true
        }
    }
}
