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
        ZStack {
            BackgroundView()
            VStack {
                Spacer()
                Text("Runde " + String(userData.currentRound ?? 0))
                HStack {
                    Text("Trumpf: ")
                    userData.currentTrump?.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }
                HStack {
                    VStack {
                        Text("-")
                        ForEach(1...(userData.currentRound ?? 1), id: \.self) { index in
                            Text("\(index)")
                        }
                        Text("----")
                        Text("/")
                    }
                    let maxValue = userData.users.map { $0.overallPoints }.max() ?? 0

                    ForEach(userData.users, id: \.id) { user in
                        VStack {
                            Text(user.name)
                                .lineLimit(1)

                            ForEach(user.pointHistory.keys.sorted(), id: \.self) { round in
                                let value = user.pointHistory[round] ?? 0
                                let display = value > 0 ? "+\(value)" : "\(value)"
                                Text(display)
                            }
                            Text("----")

                            Text(String(user.overallPoints))
                                .fontWeight(user.overallPoints == maxValue ? .bold : .regular)
                        }
                    }
                }
                Spacer()
                GoButton(label: "Nächste Runde") {
                    userData.currentRound! += 1
                    userData.currentTrump = nil
                    for index in userData.users.indices {
                        userData.users[index].currentGuess = nil
                        userData.users[index].currentStings = nil
                    }
                    showNextView = true
                }
            }
            ResetButton()
        }
        .font(.title)
        .foregroundStyle(.white)
        .fullScreenCover(isPresented: $showNextView) {
            if userData.currentRound ?? 1 > 60 / userData.users.count {
                EndView()
            } else {
                SelectTrumpView()
            }
        }
    }
}
